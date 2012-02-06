class UserCourse < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

  def role=(role)
    puts "##################################"
    puts "#{role}"
    puts "###################################"
    user.has_role role, Course.find(course_id)
  end
end
