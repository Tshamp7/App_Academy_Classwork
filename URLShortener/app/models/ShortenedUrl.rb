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

  has_many :visitors, through: :visits, source: :user

  
  

end
