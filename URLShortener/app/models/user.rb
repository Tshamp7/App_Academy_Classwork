# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  email      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
    validates :email, presence: true
    validates :email, uniqueness: true

    has_many(
        :submitted_urls,
        class_name: 'ShortenedUrl',
        foreign_key: :user_id,
        primary_key: :id
    )

    has_many(
        :visits,
        class_name: 'Visit',
        foreign_key: :user_id,
        primary_key: :id
    )

    has_many :visited_urls, through: :visits, source: :shortened_url

    def make_shortened_url(input)
        user_id = self.id
        short_url = ShortenedUrl.random_code

        ShortenedUrl.create!(
            user_id: user_id, 
            short_url: short_url, 
            long_url: input
            )

    end

end

