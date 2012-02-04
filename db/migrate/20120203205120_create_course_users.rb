class CreateCourseUsers < ActiveRecord::Migration
  def change
    create_table :course_users do |t|
      t.references  :user
      t.references  :course
      t.timestamps
    end
  end
end
