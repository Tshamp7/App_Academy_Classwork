class Response < ApplicationRecord

    belongs_to(
        :respondent,
        class_name: 'User',
        foreign_key: :user_id,
        primary_key: :id
    )

    belongs_to(
        :answer_choice,
        class_name: 'Answerchoice',
        foreign_key: :answerchoice_id,
        primary_key: :id
    )

end