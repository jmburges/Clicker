class Course < ActiveRecord::Base
  has_many :questions, :dependent => :destroy
  has_many :users, :through =>  :UserCourses
  has_many :UserCourses

  accepts_nested_attributes_for :questions,  :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :UserCourses,  :reject_if => lambda { |a| a[:user_id].blank? }, :allow_destroy => true
end
