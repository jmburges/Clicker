class User < ActiveRecord::Base
  acts_as_authentic
  rolify
  has_and_belongs_to_many :roles, :join_table => :users_roles
  has_and_belongs_to_many :courses, :join_table => :user_courses
  has_many :useranswers, :class_name => "UserAnswer"
  has_many :answers, :through => :useranswers

  scope :students, lambda { User.all.select{|user|user.role=="Student"} }
  scope :teachers, lambda { User.all.select{|user|user.role=="Teacher"} }

  
 # accepts_nested_attributes_for :userAnswers,  :reject_if => lambda { |a| a[:answer_id].blank? }, :allow_destroy => true
  
  def role=(role)
    self.add_role role
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

  def self.find_or_create_from_oauth(auth)
 where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
    user.provider = auth.provider
    user.uid = auth.uid
    user.name = auth.info.name
    user.email = auth.info.email || "fb_user_#{Time.now.hash.abs}@email.com"
    if user.new_record?
      user.password="facebook"
      user.password_confirmation="facebook"
    end
    user.oauth_token = auth.credentials.token
    user.oauth_expires_at = Time.at(auth.credentials.expires_at)
    user.add_role "Student"
    user.save!
  end
  end
end
