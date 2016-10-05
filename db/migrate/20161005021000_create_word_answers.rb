class CreateWordAnswers < ActiveRecord::Migration
  def change
    create_table :word_answers do |t|
      t.string :content
      t.boolean :is_correct
      t.integer :word_id
      t.timestamps null: false
    end
  end
end
