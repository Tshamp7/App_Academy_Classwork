class AddColumnsToTagTopics < ActiveRecord::Migration[6.0]
  def change
    add_column :tag_topics, :tag_name, :string, presence: true
    add_column :tag_topics, :tag_id, :integer, presence: true
  end
end
