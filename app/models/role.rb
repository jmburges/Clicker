class Role < ActiveRecord::Base
  acts_as_authorization_role
  POSSIBLE_ROLES=["Admin","Teacher","Student"]
end
