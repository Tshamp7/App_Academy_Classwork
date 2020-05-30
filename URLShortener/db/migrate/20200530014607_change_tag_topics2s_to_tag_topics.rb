class ChangeTagTopics2sToTagTopics < ActiveRecord::Migration[6.0]
  def change
    rename_table :tag_topics2s, :tag_topics
  end
end
