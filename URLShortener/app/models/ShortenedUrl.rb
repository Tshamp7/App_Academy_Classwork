# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint           not null, primary key
#  user_id    :integer
#  long_url   :string           not null
#  short_url  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
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
      primary_key: :id,
      dependent: :destroy
  )

  has_many :visitors, Proc.new {distinct}, through: :visits, source: :visitor
  
  has_many(
      :tags,
      class_name: 'Tagging',
      foreign_key: :shortened_url_id,
      primary_key: :id,
      dependent: :destroy
  )

  has_many :tag_topics, through: :tags, source: :tag_topic

  def num_clicks
    visitors.count
  end


  # The method below calls on the visits relation established
  # above and passes to it the rails methods select, where,
  # distinct, and count. These are all active record
  # query methods. 
  def num_recent_uniques
    visits
      .select('user_id')
      .where('created_at > ?', 10.minutes.ago)
      .distinct
      .count
  end

  def no_spamming
    created_in_last_minute = 
    ShortenedUrl
        .where('created_at >= ?', 1.minute.ago)
        .where(user_id: user_id )
        .length

        if created_in_last_minute >= 5
            errors[:Maximum] << 'of 5 short urls per minute.'
        end
  end

  def nonpremium_max(users_id)
    return true if User.find(users_id).premium

    submitted_urls = 
    ShortenedUrl
        .where(user_id: users_id).length

        if submitted_urls >= 5
            errors[:Only] << 'premium members can create more
            than 5 shortened Urls.'
        else
            return true
        end
  end

  def self.create_shortened_url(users_id, long_url, short_url: ShortenedUrl.random_code)
    new_url = ShortenedUrl.new(user_id: users_id, long_url: long_url, short_url: short_url)

    if new_url.nonpremium_max(users_id) == true
        new_url.save
    end
  end

  def self.prune(n)
    nonpremium_user_ids = User.where(premium: false).map { |user| user.id }
    things_to_destroy = 
    ShortenedUrl
        .where('created_at <= ?', n.minutes.ago)
        .where(user_id: nonpremium_user_ids)

    
    things_to_destroy.each { |shortened_url| shortened_url.destroy }
  end


end
