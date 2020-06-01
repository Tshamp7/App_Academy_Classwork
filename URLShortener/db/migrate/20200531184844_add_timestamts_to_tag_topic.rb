class AddTimestamtsToTagTopic < ActiveRecord::Migration[6.0]
  def change
    add_timestamps(:tag_topics)
  end
end
