class CreateTableShortenedUrls < ActiveRecord::Migration[6.0]
  def change
    create_table :table_shortened_urls do |t|
      t.integer :user_id
      t.string :long_url, index: {unique: true}
      t.string :short_url, index: {unique: true}
    end
  end
end
