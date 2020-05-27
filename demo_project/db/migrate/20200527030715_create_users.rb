class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.date :date_of_birth
      t.string :user_name
      t.integer :karma
    end
  end
end
