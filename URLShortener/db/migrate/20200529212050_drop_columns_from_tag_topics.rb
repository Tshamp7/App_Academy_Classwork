class DropColumnsFromTagTopics < ActiveRecord::Migration[6.0]
  def change
    remove_column :tag_topics, :shortened_url_id
    remove_column :tag_topics, :tag
  end
end

