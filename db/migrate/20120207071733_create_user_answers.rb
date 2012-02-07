class CreateUserAnswers < ActiveRecord::Migration
  def change
    create_table :user_answers do |t|
      t.references :user
      t.references :answer
    end
  end
end
