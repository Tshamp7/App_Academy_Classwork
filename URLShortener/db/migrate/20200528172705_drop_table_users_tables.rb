class DropTableUsersTables < ActiveRecord::Migration[6.0]
  def change
    drop_table :users_tables
  end
end
