class DropTagIdFromTagTopics < ActiveRecord::Migration[6.0]
  def change
    remove_column :tag_topics, :tag_id
  end
end
