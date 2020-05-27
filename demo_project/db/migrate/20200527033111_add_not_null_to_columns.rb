class AddNotNullToColumns < ActiveRecord::Migration[6.0]
  def change
    change_column_null(:users, :name, false)
    change_column_null(:users, :date_of_birth, false)
    change_column_null(:users, :user_name, false)
  end
end
