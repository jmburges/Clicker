class Answer < ActiveRecord::Base
  belongs_to :question
  has_many :users, :through => :useranswers
  has_many :useranswers, :class_name => "UserAnswer"


  #accepts_nested_attributes_for :useranswers,  :reject_if => lambda { |a| a[:user_id].blank? }, :allow_destroy => true


end
