class Answer < ActiveRecord::Base
  belongs_to :question

  def correct_answer=(answer)
    if(answer)
      self.question.correct_answer=self
      self.question.save
    end
  end

  def correct_answer
    if(!self.question.nil?)
      return self.question.correct_answer_id==self.id
    end
    return false
  end
  
  def _destroy=(destroyer)
    if !destroyer.empty?
      self.destroy
    end
  end

end
