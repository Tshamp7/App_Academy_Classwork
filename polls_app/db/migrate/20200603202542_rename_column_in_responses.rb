class RenameColumnInResponses < ActiveRecord::Migration[6.0]
  def change
    rename_column :responses, :answerchoices_id, :answerchoice_id
  end
end
