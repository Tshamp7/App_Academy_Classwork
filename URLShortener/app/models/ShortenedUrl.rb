# == Schema Information
#
# Table name: shortened_urls
#
#  id        :bigint           not null, primary key
#  user_id   :integer
#  long_url  :string           not null
#  short_url :string
#
require 'securerandom'

class ShortenedUrl < ApplicationRecord
  validates :short_url, uniqueness: true
  validates :long_url, uniqueness: true

  def self.random_code
    random_url = SecureRandom.urlsafe_base64
    while self.exists?(short_url: random_url)
        random_url = SecureRandom.urlsafe_base64
    end
    random_url
  end

  belongs_to(
      :user,
      class_name: 'User',
      foreign_key: :user_id,
      primary_key: :id
  )

  has_many(
      :visits,
      class_name: 'Visit',
      foreign_key: :shortened_url_id,
      primary_key: :id
  )

  has_many :visitors, Proc.new {distinct}, through: :visits, source: :visitor
  
  has_many(
      :tags,
      class_name: 'Tagging',
      foreign_key: :shortened_url_id,
      primary_key: :id
  )

  has_many :tag_topics, through: :tags, source: :tag_topic

  def num_clicks
    visitors.count
  end

  def num_recent_uniques
    visits
      .select('user_id')
      .where('created_at > ?', 10.minutes.ago)
      .distinct
      .count
  end
  

end
