class ChangeConstraintOnTagTopicRemovedTagColumn < ActiveRecord::Migration[6.0]
  def change
    change_column_null :tag_topics, :tag, :true
  end
end
