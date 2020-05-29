class AddColumnsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :email, :string, null: false
    add_index :users, :email # this will allow for quick lookup.
  end
end
