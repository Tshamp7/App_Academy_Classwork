class ChangeResponseColumnNameBack < ActiveRecord::Migration[6.0]
  def change
    rename_column :responses, :responder_id, :user_id
  end
end
