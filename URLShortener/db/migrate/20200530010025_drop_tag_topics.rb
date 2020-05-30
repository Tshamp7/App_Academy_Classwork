class DropTagTopics < ActiveRecord::Migration[6.0]
  def change
    drop_table :tag_topics
  end
end
