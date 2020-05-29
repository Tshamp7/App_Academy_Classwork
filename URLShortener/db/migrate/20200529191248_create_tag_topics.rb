class CreateTagTopics < ActiveRecord::Migration[6.0]
  def change
    create_table :tag_topics do |t|
      t.integer :shortened_url_id, null: false
      t.string :tag, null: false
    end
  end
end
