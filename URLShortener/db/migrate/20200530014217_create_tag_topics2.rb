class CreateTagTopics2 < ActiveRecord::Migration[6.0]
  def change
    create_table :tag_topics2s do |t|
      t.string :tag_name, null: false
      t.integer :tag_id, null: false
    end
  end
end
  
