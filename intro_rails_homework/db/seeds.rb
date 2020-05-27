# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
house1 = House.create(address: '32710 SE Wood dr')
house2 = House.create(address: 'The trailer')
house3 = House.create(address: '17 Riverview St.')
house4 = House.create(address: 'Julies House!')

person1 = Person.create(name: 'Josephine Q', house_id: house1.id)
person2 = Person.create(name: 'Amber Shamp', house_id: house1.id)
person3 = Person.create(name: 'Tom Shamp', house_id: house1.id)
person4 = Person.create(name: 'Kai Shamp', house_id: house1.id)
person5 = Person.create(name: 'Mama', house_id: house3.id)
person6 = Person.create(name: 'Ted Shamp', house_id: house2.id)
person7 = Person.create(name: 'Juice', house_id: house4.id)

