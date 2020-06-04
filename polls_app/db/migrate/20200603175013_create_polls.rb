class CreatePolls < ActiveRecord::Migration[6.0]
  def change
    create_table :polls do |t|
      t.string :title, index: { unique: true }
      t.integer :user_id, null: false
    end
  end
end
