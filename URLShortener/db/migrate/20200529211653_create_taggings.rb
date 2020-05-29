class CreateTaggings < ActiveRecord::Migration[6.0]
  def change
    create_table :taggings do |t|
     t.integer :tagtopic_id, null: false
     t.integer :shortened_url_id, null: false
    end
  end
end
