class FixCorrectAnswer < ActiveRecord::Migration
  def up
    remove_column :questions, :correct_answer_id
    add_column :answers, :correct, :boolean, :default=>false
  end
 
  def down
    add_column :questions, :correct_answer_id, :integer
    remove_column :answers, :correct
  end
end
