class Course < ActiveRecord::Base
  has_many :questions, :dependent => :destroy
  has_and_belongs_to_many :users, :join_table => :user_courses
  resourcify

  accepts_nested_attributes_for :questions,  :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true
end
