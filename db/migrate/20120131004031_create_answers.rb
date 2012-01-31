class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :content
      t.int :question_id

      t.timestamps
    end
  end
end
