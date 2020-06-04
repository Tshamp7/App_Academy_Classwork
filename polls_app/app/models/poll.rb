class Poll < ApplicationRecord
    validates :title, uniqueness: true

    belongs_to(
        :author,
        class_name: 'User',
        foreign_key: :user_id,
        primary_key: :id
        )

    has_one(
        :question,
        class_name: 'Question',
        foreign_key: :poll_id,
        primary_key: :id
    )
end