class User < ActiveRecord::Base
  acts_as_authentic
  include Rolify::Roles
  # extend Rolify::Dynamic
  has_and_belongs_to_many :roles, :join_table => :users_roles
  has_many :courses, :through => :UserCourses
  has_many :UserCourses
  has_many :UserAnswers
  has_many :users, :through => :UserAnswers

  scope :students, lambda { User.all.select{|user|user.role=="Student"} }
  scope :teachers, lambda { User.all.select{|user|user.role=="Teacher"} }

  
  def role=(role)
    Role::POSSIBLE_ROLES.each do |role|
      self.has_no_role role
    end
    self.has_role role
  end

  def role
    self.roles.first.name unless self.roles.empty?
  end
end
