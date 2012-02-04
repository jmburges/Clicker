class Course < ActiveRecord::Base
  has_many :questions, :dependent => :destroy
  has_many :course_users
  has_many :users, :through => :course_users
  accepts_nested_attributes_for :questions,  :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :users, :allow_destroy => true
  accepts_nested_attributes_for :course_users,  :reject_if => lambda { |a| a[:user_id].blank? }, :allow_destroy => true

end
