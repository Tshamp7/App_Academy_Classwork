class CreateAnswerchoices < ActiveRecord::Migration[6.0]
  def change
    create_table :answerchoices do |t|
      t.string :text, null: false
      t.integer :question_id, null: false
    end
  end
end
