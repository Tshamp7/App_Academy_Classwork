class Course < ApplicationRecord
    has_many(
        :enrollments,
        class_name: 'Enrollment',
        foreign_key: :course_id,
        primary_key: :id
    )

    has_many :users, through: :enrollments, source: :user

    belongs_to(
        :prerequisite,
        class_name: 'Course',
        foreign_key: :prereq_id,
        primary_key: :id,
        optional: true
    )

    belongs_to(
        :instructor,
        class_name: 'User',
        foreign_key: :instructor_id,
        primary_key: :id
    )

    # The table in which the foreign key is stored 
    # 'belongs_to' the table which the foreign key
    # is referencing.

    
end
