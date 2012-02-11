class User < ActiveRecord::Base
  acts_as_authentic
  include Rolify::Roles
  # extend Rolify::Dynamic
  has_and_belongs_to_many :roles, :join_table => :users_roles
  has_and_belongs_to_many :courses, :join_table => :user_courses
  has_many :useranswers, :class_name => "UserAnswer"
  has_many :answers, :through => :useranswers

  scope :students, lambda { User.all.select{|user|user.role=="Student"} }
  scope :teachers, lambda { User.all.select{|user|user.role=="Teacher"} }

  
 # accepts_nested_attributes_for :userAnswers,  :reject_if => lambda { |a| a[:answer_id].blank? }, :allow_destroy => true
  
  def role=(role)
    Role::POSSIBLE_ROLES.each do |role|
      self.has_no_role role
    end
    self.has_role role
  end

  def role
    self.roles.first.name unless self.roles.empty?
  end

  def answered_question(question)
    question.answers.each do |answer|
      if answers.include?(answer)
        return answer
      end
    end
    return nil
  end

  def admin?
    self.role=="Admin"
  end

  def student?
    self.role=="Student"
  end

  def teacher?
    self.role=="Teacher"
  end
end
