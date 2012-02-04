class User < ActiveRecord::Base
  has_many :courses, :through => :course_users
  has_many :course_users
  acts_as_authentic
  acts_as_authorization_subject  :association_name => :roles
  acts_as_authorization_object

  def role=(role)
    self.has_role! Role::POSSIBLE_ROLES[role.to_i], self
  end

  def role
    self.roles_for(nil).first
  end
end
