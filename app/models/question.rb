class Question < ActiveRecord::Base
  has_many :answers, :dependent => :destroy
  has_many :answered_users, :through => :answers, :source => "users"
  belongs_to :course
  accepts_nested_attributes_for :answers,  :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true

  def open?
    startdate<Time.now && enddate>Time.now
  end

  def correct_answers
    answers.where("correct=?", true)
  end

  def correct_users
    correct_user = Array.new
    self.answered_users.each do |user|
      if user_is_correct?(user)
        correct_user << user
      end
    end
    correct_user
  end


  def user_is_correct?(user)
    !(correct_answers & user.answers).empty?
  end
 
end
