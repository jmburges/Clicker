class Question < ActiveRecord::Base
  has_many :answers, :dependent => :destroy
  belongs_to :course
  accepts_nested_attributes_for :answers,  :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true

  def open?
    startdate<Time.now && enddate>Time.now
  end
  
end
