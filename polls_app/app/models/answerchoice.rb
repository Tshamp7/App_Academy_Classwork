class Answerchoice < ApplicationRecord
    validates :text, presence: true
    validates :question_id, presence: true

    belongs_to(
        :question,
        class_name: 'Question',
        foreign_key: :question_id,
        primary_key: :id
    )

    has_many(
        :responses,
        class_name: 'Response',
        foreign_key: :answerchoice_id,
        primary_key: :id
    )
end