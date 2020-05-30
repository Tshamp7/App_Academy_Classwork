# == Schema Information
#
# Table name: tag_topics
#
#  id       :bigint           not null, primary key
#  tag_name :string           not null
#  tag_id   :integer          not null
#
class TagTopic < ApplicationRecord
    validates :tag_name, presence: true

    has_many(
        :tags,
        class_name: 'Tagging',
        foreign_key: :tag_topic_id,
        primary_key: :id
    )

    has_many :shortened_urls,  through: :tags, source: :shortened_url




end
