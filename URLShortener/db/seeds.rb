# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# TagTopic.create!(tag_name: "sports")
# TagTopic.create!(tag_name: "cats")
# TagTopic.create!(tag_name: "dogs")
# TagTopic.create!(tag_name: "backend")
# TagTopic.create!(tag_name: "Ruby on Rails")
# TagTopic.create!(tag_name: "software engineering")
# TagTopic.create!(tag_name: "pizza")
# TagTopic.create!(tag_name: "food")
# TagTopic.create!(tag_name: "dog treats")

Tagging.create!(tag_topic_id: 11, shortened_url_id: 1)
Tagging.create!(tag_topic_id: 12, shortened_url_id: 2)
Tagging.create!(tag_topic_id: 4, shortened_url_id: 3)
Tagging.create!(tag_topic_id: 5, shortened_url_id: 4)
Tagging.create!(tag_topic_id: 6, shortened_url_id: 5)
