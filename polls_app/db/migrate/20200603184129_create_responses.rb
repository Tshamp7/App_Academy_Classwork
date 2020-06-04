class CreateResponses < ActiveRecord::Migration[6.0]
  def change
    create_table :responses do |t|
      t.integer :user_id, null: false
      t.integer :answerchoices_id, null: false
    end
  end
end
