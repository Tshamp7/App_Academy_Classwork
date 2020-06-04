class ChangeResponseColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :responses, :user_id, :responder_id
  end
end
