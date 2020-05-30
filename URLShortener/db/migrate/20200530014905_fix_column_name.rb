class FixColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :taggings, :tagtopic_id, :tag_topic_id
  end
end
