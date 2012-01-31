class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :content
      t.integer :correct_answer_id
      t.datetime :startdate
      t.datetime :enddate

      t.timestamps
    end
  end
end
