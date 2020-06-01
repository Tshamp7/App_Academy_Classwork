class AddTimestampsToTaggings < ActiveRecord::Migration[6.0]
  def change
    add_timestamps(:taggings)
  end
end
