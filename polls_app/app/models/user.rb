class User < ApplicationRecord
    validates :username, uniqueness: true

    has_many(
        :authored_polls,
        class_name: 'Poll',
        foreign_key: :user_id,
        foreign_key: :id
    )

    has_many(
        :responses,
        class_name: 'Response',
        foreign_key: :responders_id,
        primary_key: :id
    )
end