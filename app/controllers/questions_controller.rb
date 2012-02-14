class QuestionsController < ApplicationController
 load_and_authorize_resource 
  # GET /questions
  # GET /questions.json
  def index
    #question is loaded by load_and_authorize_resource
    @course = Course.find(params[:course_id])
    @questions = @course.questions
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @questions }
    end
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    @question = Question.find(params[:id])

    #Has current_user answered the question?
    if answer=current_user.answered_question(@question)
      @useranswer =UserAnswer.where("user_id=#{current_user.id} AND answer_id=#{answer.id}").first
    else 
      @useranswer = current_user.useranswers.build
    end

    #Set up the table
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string', 'Answer')
    data_table.new_column('number', 'Responses')
    data_table.add_rows(@question.answers.size)
    @question.answers.each_with_index do |answer,i|
      data_table.set_cell(i,0,answer.content)
      data_table.set_cell(i,1,answer.users.size)
    end
    opts   = { :width => 400, :height => 240, :title => 'Responses', :legend=>{:position => "none"} }
    @chart = GoogleVisualr::Interactive::ColumnChart.new(data_table, opts)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @question }
    end
  end

  # GET /questions/new
  # GET /questions/new.json
  def new
    @question = Question.new
    @course = Course.find(params[:course_id])
    @question.course_id=params[:course_id]
    @answers = @question.answers.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @question }
    end
  end

  # GET /questions/1/edit
  def edit
    @question = Question.find(params[:id])
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(params[:question])
    respond_to do |format|
      if @question.save
        puts params
        format.html { redirect_to course_question_path(@question.course,@question), notice: 'Question was successfully created.' }
        format.json { render json: @question, status: :created, location: @question }
      else
        format.html { render action: "new" }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /questions/1
  # PUT /questions/1.json
  def update
    @question = Question.find(params[:id])

    respond_to do |format|
      if @question.update_attributes(params[:question])
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question = Question.find(params[:id])
    @question.destroy

    respond_to do |format|
      format.html { redirect_to questions_url }
      format.json { head :no_content }
    end
  end

  def open_question
    @question = Question.find(params[:id])
    seconds = params[:seconds].to_i+params[:minutes].to_i*60
    @question.startdate = Time.now
    @question.enddate= @question.startdate+seconds
    @question.save
  end

  def stop
    @question=Question.find(params[:id])
    authorize! :stop ,@question
    @question.enddate = Time.now
    @question.save
  end
end
