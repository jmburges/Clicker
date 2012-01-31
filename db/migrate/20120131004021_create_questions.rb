class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :content
      t.int :correct_answer_id
      t.datetime :startdate
      t.datetime :enddate

      t.timestamps
    end
  end
end
