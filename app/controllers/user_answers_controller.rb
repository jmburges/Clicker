class UserAnswersController < ApplicationController
  load_and_authorize_resource
  # POST /useranswers
  # POST /useranswers.json
  def create
    @useranswer = UserAnswer.new(params[:user_answer])
    respond_to do |format|
      if @useranswer.save
        format.html { redirect_to course_questions_path(@useranswer.answer.question), notice: 'useranswer was successfully created.' }
        format.json { render json: @useranswer, status: :created, location: @useranswer }
      else
        format.html { render action: "new" }
        format.json { render json: @useranswer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /useranswers/1
  # PUT /useranswers/1.json
  def update
    @useranswer = UserAnswer.find(params[:id])

    respond_to do |format|
      if @useranswer.update_attributes(params[:user_answer])
        format.html { redirect_to course_question_url(@useranswer.answer.question.course, @useranswer.answer.question), notice: 'useranswer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @useranswer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /useranswers/1
  # DELETE /useranswers/1.json
  def destroy
    @useranswer = UserAnswer.find(params[:id])
    @useranswer.destroy

    respond_to do |format|
      format.html { redirect_to courses_url }
      format.json { head :no_content }
    end
  end
end
