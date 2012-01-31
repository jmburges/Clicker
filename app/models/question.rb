class Question < ActiveRecord::Base
  has_many :answers
  belongs_to :correct_answer, :class_name=>"Answer"
end
