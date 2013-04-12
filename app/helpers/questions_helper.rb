module QuestionsHelper
  def chart_tag (course,question, height, params = {})
    params[:format] ||= :json
    path = course_question_answer_graph_path(course,question)
    content_tag(:div, :'data-chart' => path, :style => "height: #{height}px;") do
      image_tag('spinner.gif', :size => '24x24', :class => 'spinner')
    end
  end
end
