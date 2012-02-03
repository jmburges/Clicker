class User < ActiveRecord::Base
  acts_as_authentic
  acts_as_authorization_subject  :association_name => :roles

  def role=(role)
    self.has_role! Role::POSSIBLE_ROLES[role.to_i]
  end

  def role
    self.roles_for(nil).first
  end
end
