# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(username: 'Tomsthebestdude678') #1
User.create!(username: 'Ambolambo666') #2
User.create!(username: 'CheetsMageets401') #3 
User.create!(username: 'Kaidogdoober123') #4
User.create!(username: 'TheOneAndOnlyJoe') #5
User.create!(username: 'WashougalTed') #6
User.create!(username: 'BrownielovinGrandma') #7 

Poll.create!(title: 'Brownies poll', user_id: 7) #1
Poll.create!(title: 'Programming languages', user_id: 2) #2
Poll.create!(title: 'Batle Royale poll', user_id: 3) #3
Poll.create!(title: 'Muscle cars', user_id: 1) #4
Poll.create!(title: 'Nap spots', user_id: 5) #5
Poll.create!(title: 'Should I bork?', user_id: 4) #6
Poll.create!(title: 'Coupon ideas', user_id: 6) #7

Question.create!(text: 'How good do you think these brownies are?!', poll_id: 1)
Question.create!(text: 'Which programming language is your favorite?', poll_id: 2)
Question.create!(text: 'Which one of these battle royale games is better?', poll_id: 3)
Question.create!(text: 'Which muscle car is better?', poll_id: 4)
Question.create!(text: 'Where should I nap today?', poll_id: 5)
Question.create!(text: 'What should I bork at?', poll_id: 6)
Question.create!(text: 'Which one of these coupon ideas should I put in my new book?!', poll_id: 7)

Answerchoice.create!(question_id: 1, text: 'Not so good...') #1
Answerchoice.create!(question_id: 1, text: 'Meh, they\'re okay') #2
Answerchoice.create!(question_id: 1, text: 'Very good!') #3
Answerchoice.create!(question_id: 1, text: 'OMGGG SOO GOOD!') #4

Answerchoice.create!(question_id: 2, text: 'Ruby') #5
Answerchoice.create!(question_id: 2, text: 'Javascript') #6
Answerchoice.create!(question_id: 2, text: 'C#') #7
Answerchoice.create!(question_id: 2, text: 'Python') #8

Answerchoice.create!(question_id: 3, text: 'Warzone') #9
Answerchoice.create!(question_id: 3, text: 'Apex: legends') #10
Answerchoice.create!(question_id: 3, text: 'Blackout') #11
Answerchoice.create!(question_id: 3, text: 'Frog Battle Royale') #12

Answerchoice.create!(question_id: 4, text: 'Nova') #13
Answerchoice.create!(question_id: 4, text: 'LeMans') #14
Answerchoice.create!(question_id: 4, text: 'Chevelle') #15
Answerchoice.create!(question_id: 4, text: 'Impala') #16

Answerchoice.create!(question_id: 5, text: 'Cardboard Box') #17
Answerchoice.create!(question_id: 5, text: 'Floor Blanket') #18
Answerchoice.create!(question_id: 5, text: 'Face down on the futon') #19
Answerchoice.create!(question_id: 5, text: 'In space with lasers') #20

Answerchoice.create!(question_id: 6, text: 'Neighbors kids') #21
Answerchoice.create!(question_id: 6, text: 'Random Car') #22
Answerchoice.create!(question_id: 6, text: 'Duck in river') #23
Answerchoice.create!(question_id: 6, text: 'Nothing') #24

Answerchoice.create!(question_id: 7, text: 'Strip clubs') #25
Answerchoice.create!(question_id: 7, text: 'Shooting ranges') #26
Answerchoice.create!(question_id: 7, text: 'Paintball Courses') #27
Answerchoice.create!(question_id: 7, text: 'Korean BBQ') #28

Response.create!(answerchoice_id: 1 , user_id: 1) 
Response.create!(answerchoice_id: 5, user_id: 1)
Response.create!(answerchoice_id: 9, user_id: 1)
Response.create!(answerchoice_id: 13, user_id: 1)
Response.create!(answerchoice_id: 20, user_id: 1)
Response.create!(answerchoice_id: 24, user_id: 1)
Response.create!(answerchoice_id: 25, user_id: 1)

Response.create!(answerchoice_id: 1 , user_id: 2)
Response.create!(answerchoice_id: 6, user_id: 2)
Response.create!(answerchoice_id: 11, user_id: 2)
Response.create!(answerchoice_id: 13, user_id: 2)
Response.create!(answerchoice_id: 20, user_id: 2)
Response.create!(answerchoice_id: 24, user_id: 2)
Response.create!(answerchoice_id: 28, user_id: 2)

Response.create!(answerchoice_id: 2 , user_id: 3)
Response.create!(answerchoice_id: 7, user_id: 3)
Response.create!(answerchoice_id: 10, user_id: 3)
Response.create!(answerchoice_id: 13, user_id: 3)
Response.create!(answerchoice_id: 20, user_id: 3)
Response.create!(answerchoice_id: 22, user_id: 3)
Response.create!(answerchoice_id: 27, user_id: 3)

Response.create!(answerchoice_id: 3, user_id: 4)
Response.create!(answerchoice_id: 8, user_id: 4)
Response.create!(answerchoice_id: 9, user_id: 4)
Response.create!(answerchoice_id: 16, user_id: 4)
Response.create!(answerchoice_id: 20, user_id: 4)
Response.create!(answerchoice_id: 21, user_id: 4)
Response.create!(answerchoice_id: 25, user_id: 4)

Response.create!(answerchoice_id: 1, user_id: 5)
Response.create!(answerchoice_id: 6, user_id: 5)
Response.create!(answerchoice_id: 9, user_id: 5)
Response.create!(answerchoice_id: 14, user_id: 5)
Response.create!(answerchoice_id: 20, user_id: 5)
Response.create!(answerchoice_id: 23, user_id: 5)
Response.create!(answerchoice_id: 26, user_id: 5)

Response.create!(answerchoice_id: 4, user_id: 6)
Response.create!(answerchoice_id: 6, user_id: 6)
Response.create!(answerchoice_id: 9, user_id: 6)
Response.create!(answerchoice_id: 13, user_id: 6)
Response.create!(answerchoice_id: 20, user_id: 6)
Response.create!(answerchoice_id: 21, user_id: 6)
Response.create!(answerchoice_id: 28, user_id: 6)

Response.create!(answerchoice_id: 1, user_id: 7)
Response.create!(answerchoice_id: 7, user_id: 7)
Response.create!(answerchoice_id: 9, user_id: 7)
Response.create!(answerchoice_id: 16, user_id: 7)
Response.create!(answerchoice_id: 20, user_id: 7)
Response.create!(answerchoice_id: 24, user_id: 7)
Response.create!(answerchoice_id: 27, user_id: 7)