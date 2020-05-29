class MakeShortenedUrlsLongUrlRequiredAgain < ActiveRecord::Migration[6.0]
  def change
    change_column_null(:shortened_urls, :long_url, false)
  end
end
