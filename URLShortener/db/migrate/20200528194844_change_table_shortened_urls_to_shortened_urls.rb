class ChangeTableShortenedUrlsToShortenedUrls < ActiveRecord::Migration[6.0]
  def change
    rename_table :table_shortened_urls, :shortened_urls
  end
end
