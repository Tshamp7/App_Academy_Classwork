## Clear tmp Cache
This is for clearing the cache in the tmp folder
```
rails tmp:cache:clear              
```


gems to install for rails project:

in development:

gem 'annotate'

gem 'better_errors'

gem 'binding_of_caller'

gem 'byebug'

gem 'pry-rails'

## Creating Database

to create a database, you must run the following command:
```
bundle exec rails db:create
```

## Rails Associations

The following tables created with rails:

```
class CreateCoursesAndProfessorsTables < ActiveRecord::Migration[5.1]
  def change
    create_table :professors do |t|
      t.string :name
      t.string :thesis_title

      t.timestamps
    end

    create_table :courses do |t|
      t.string :course_name
      t.integer :professor_id
    end
  end
end
```

Would use these Associations to have access to each other:
```
class Course < ApplicationRecord
  belongs_to(
    :professor,
    class_name: 'Professor',
    foreign_key: :professor_id,
    primary_key: :id
  )
end

class Professor < ApplicationRecord
  has_many(
    :courses,
    class_name: 'Course',
    foreign_key: :professor_id,
    primary_key: :id
  )
end
```

These associations tell ActiveRecord (through ApplicationRecord), that there is a connection between the models.

Rails needs the primary_key and foreign_key attributes so that it knows how courses and professors are connected. This information is used to generate the proper SQL queries.

The class_name attribute is also necessary, since this tells Rails what other table to look up, and what kind of model object to construct with the result. Without the class namem Rails wouldn't know to build course objects to return from the Professor#courses call. 

## belongs_to vs. has_many

### belongs_to
belongs_to sets up a connection that will fetch a single associated object. Use a belongs_to association when an object has a foreign key that points to the associated record. In the above example, a Course belongs_to a Professor because courses records hold a professor_id foreign key. 

As the primary key is unique, accessing a belongs_to association will only return one object. Note that when the association was defined, we used the singular form of Professors, which is Professor. This is because a course has a single foreign keythat refers to a single professor. 

As of Rails 5, belongs_to associations are validation for presence by default. You can opt out of this behavior (ie. allow the association to be null) by adding the key-value pair optional:true to your association like so:
```
class Course < ApplicationRecord
  belongs_to(
    :professor,
    class_name: 'Professor',
    foreign_key: :professor_id,
    primary_key: :id,
    optional: true
  )
end
```

### has_many
We use belongs_to when the record holds a foreign key that references an associated object. What if we want to go in the opposite direction?

The answer is to use has_many. We use has_many when a record holds a column (the pimary key) that is referred to by a foreign key in the associated records.

Note that because a foreign key is not expected to be unique, many records in a table may all refer to the same object. For that reason, has_many associations can yield multiple associated records, as their name suggests.

In our examples, professors owns the primary key id. This primary key is referred to by courses' professors_id attribute. The right choice here is has_many and not belongs_to because professors is referred to by the associated object.

Note that the name of a has_many association is pluralized, since the method will return an array (possible empty) of associated objects.

### Deciding between belongs_to and has_many

When defining an association, you need to figure out whether to use belongs_to or has_many. The rule is that if the record holds a reference pointing to the associated record, use belongs_to. If the record is pointed to by the associated records, use has_many. 

## has_many: through

### The problem

We've defined two kinds of associations; belongs_to associates a record holding a foreign key to the record the key points to, while has_many associates a record with one or more entities that hold a foreign key pointing to it. 

What about indirect relations? For instance, consider the following example:
```
class Physician < ApplicationRecord
  has_many(
    :appointments,
    class_name: 'Appointment',
    foreign_key: :physician_id,
    primary_key: :id
  )
end

class Appointment < ApplicationRecord
  belongs_to(
    :physician,
    class_name: 'Physician',
    foreign_key: :physician_id,
    primary_key: :id
  )

  belongs_to(
    :patient,
    class_name: 'Patient',
    foreign_key: :patient_id,
    primary_key: :id
  )
end

class Patient < ApplicationRecord
  has_many(
    :appointments
    class_name: 'Appointment',
    foreign_key: :patient_id,
    primary_key: :id
  )
end
```

In the above example, both a physician and a patient may have many appointments. What if we want to get all the Patients who have an Appointment with a given Physician? One way to do this is to get the Appointments for the Physician, then loop through these to get the Patient objects:

```
patients = physician.appointments.map do |appointment|
  appointment.patient
end
```

The problem with the above way of writing this query is that this will fire off another DB query for each appointment. So, if the Physician has 100's of appointments, this will fire 100's of DB querys. This could significantly slow down our application.

### The solution: has_many: through

We can use another kind of solution to solve this problem which is known as a has_many :through association.

```
class Physician < ApplicationRecord
  has_many(
    :appointments,
    class_name: 'Appointment',
    foreign_key: :physician_id,
    primary_key: :id
  )
# See below!
  has_many :patients, through: :appointments, source: :patient
end

class Appointment < ApplicationRecord
  belongs_to(
    :physician,
    class_name: 'Physician',
    foreign_key: :physician_id,
    primary_key: :id
  )

  belongs_to(
    :patient,
    class_name: 'Patient',
    foreign_key: :patient_id,
    primary_key: :id
  )
end

class Patient < ApplicationRecord
  has_many(
    :appointments
    class_name: 'Appointment',
    foreign_key: :patient_id,
    primary_key: :id
  )
# See below!
  has_many :physicians, through: :appointments, source: :physician
end
```

A has_many :through association associates records through other tables. 

The most critical thing here is to note that :through and :source name other associations. has_many :through links associations. These other associations are defined first and are then joined together by using has_many :through. Note that the through association must be made in both directions, in this case from Physicians to Patients and also from Patients to Physicians. 

### The SQL for a has_many :through

The SQL generated by a has_many :through in this examples is as follows:

```
physician.patients
# SELECT 
#  patients.*
# FROM
#  appointments
# JOIN
#  patients ON appointments.patient_id = patients.id
# WHERE
#  appointments.physician_id = ?
```

The has_many :through assocation joins the two tables using an SQL JOIN. has_many :through does not care about the kind of associations it is linking, just like an SQL query does not care about the kinds of tables it is joining. We could go :through a belongs_to and onward with a :source of has_many. Or, another option is to combine to has_many associations.

## Associations: has_one

### has_one and HABTM

The has_one Association

has_one is a has_many association where at most one associated record will exist. As a convenience, instead of returning an empty or one-element array, has_one will return the associated object (or nil, if the associated object doesn't exist).

has_one is not very common, because it implies that there is a one_to_one association between two records in the database. In that case, it would be more typical for those two tables to be merged. 

One exception to this is if one of the tables contains a lot of "wide" columns that contain a lot of data and is not likely to be used often. In that case, you may wish to extract some of the "wide" columns into a table that is related 1 to 1. 

### has_one :through

This acts the same as has_many :through, but tells ActiveRecord that only one record will be returned, so don't put it in an array. This exactly analogous to what you saw with traditional has_one vs has_many. Because it wouldn't make sense to use a has_many :through which traverse a has_many association, has_one :through is used to link up belongs_to and has_one associations only. 

## Unconventional Associations

We've learned about the class_name/foreign_key/primary_key options for belongs_to and has_many. We know that Rails can often infer these. Let's see an example where it cannot:
```
class Employee < ApplicationRecord
  has_many :subordinates,
    class_name: 'Employee',
    foreign_key: :manager_id,
    primary_key: :id

  belongs_to :manager,
    class_name: 'Employee',
    foreign_key: :manager_id,
    primary_key: :id
end
```

This can be called a reflexive association, because
the association refers back to the same table. Here, there is a employees.manager_id column that refers to
employeed.id column. The table is referencing its own rows' id columns as employees are overseen by other employees. 

Here we use the non-standard association names 
subordinates / manager instead of employees / employee.
Rails would get confused if we had two associations on the same class that differ only in pluralization. Note also that, where the column name being referenced would have typically been employee_id, here I have used manager_id which better explains the nature of the key. 

## Two associations to the same class

Lets look at another examples:
```
# emails: id|from_email_address|to_email_address|text
#  users: id|email_address

class User < ApplicationRecord
  has_many(
    :sent_emails,
    class_name: 'Email',
    foreign_key: :from_email_address,
    primary_key: :email_address
  )
  has_many(
    :received_emails,
    class_name: 'Email',
    foreign_key: :to_email_address,
    primary_key: :email_address
  )
end

class Email < ApplicationRecord
  belongs_to(
    :sender,
    class_name: 'User',
    foreign_key: :from_email_address,
    primary_key: :email_address
  )
  belongs_to(
    :recipient,
    class_name: 'User',
    foreign_key: :to_email_address,
    primary_key: :email_address
  )
end
```
Here the Email and User objects are associated in two ways: sender and recipient. Additionally, the Email record does not reference User's id field directly; instead, it refers to an email_address. For that reason, we need to specify the primary_key option; this is otherwise by default simply id. 

## Basic Validations

### Validations I: Basics

This quide teaches you how to validate that objects are correctly filled out before they go into the database. Validations are used to ensure that only valid data is saved into your database. For example, it may be important to your application to ensure that every user provides a valid email address and mailing address. Validations keep garbage data out.

### Validations vs. Constraints

We need to make an important distinction here. Rails validations are not the same as database constraints, though they are conceptually similar. Both try to ensure data integrity and consistency, but validations operate in your Ruby code, while constraints operate in the database. So the basic rule is:

    - Validations are defined inside modules.
    - Constraints are defined inside migrations.

### Use Constraints

We've seen how to write some database constraints in SQL (NOT NULL, FOREIGN KEYm UNIQUE, INDEX). These are enforced by the database and are very strong. Not only will they keep bugs in our Rails app from puting bad data into the database, they'll also stop bad data coming from other sources (SQL scripts, the database console, etc.). We will frequently use simple DB constraints like these to ensure data consistency.

However, for complicated validations, DB constaints can be terrible to write in SQL. Also, when a DB constraint fails, a generic error is thrown to Rails (SQLException). In general, Rails will not handle errors like these, and a web users request will fail with an ugly 500 Internal Server Error. 

### Use Validations

It is for this error-handling reason that DB constaints are not appropriate for validating user input. If a user chooses a previously chosen username, they shiuld not get a 500 error page; Rails should nicely ask for another name. This is what model-level validations are good at. 

Model-level validations live in the Rails world. Because we write them in Ruby, they are very flexible, database agnositc, and convenient to test, maintain and reuse. Rails provides built-in helpers for common validations, making them easy to add. Many things we can validate in the Rails layer would be very difficult to enforce at the DB layer. 

### Use Both!

Often you will use both together. For example, you might use a NOT NULL constaint to guarantee good data while also taking advantage of the user messaging provided by a corresponding presence: true validation. 

Perhaps a better example of this would be uniqueness. A uniqueness: true validation is good for displaying useful feedback to users, but it cannot acutally guarantee uniqueness. It operated inside a single server process and doesn't know what any other servers are doing. Two servers could submit queries to the DB with conflicting data at the same time and the validation would not catch it. Because a UNIQUE constaint operates in the databse and not in the server, it will cause on of those requests to fail, preserving the integrity of your data. 

### When does validation happen?

Whenever you call save/save! on a model, ActiveRecord will first run the validations to make sure the data is valid to be persisted permanently to the database. If any validations fail, the object will be marked as invalid and ActiveRecord will not perform the INSERT or UPDATE operation. This keeps invalid data from being inserted into the databse. 

To signal success saving the object, save will return true; otherwise false is returned. save! will instead raise an error if the validations fail. 

### valid?

Before saving, ActiveRcord calls the valid? method; thi is what actually triggers the validations to run. If any fail, valid? returns false. Of course, when save/save! call valid? they are expecting to get true back. If not, ActiveRecord won't actually perform the SQL INSERT/UPDATE.
```
class Person < ApplicationRecord
  validates :name, presence: true
end

Person.create(name: 'John Doe').valid? # => true
Person.create(name: nil).valid? # => false
```

### erros

Okay so we know an object is invalid, but what's wrong with it? We can get a hash-like object through the #erros method. #erros returns an instance of ActiveModel::Errors, but it can be used like a Hash. The keys are attribute names, the values are arrays of all the errors for each attribute. If there are no errors on the specified attribute, an empty array is returned. 

The erros method is only useful after validations have been run, because it only inspects the errors collection and does not trigger validations itself. You should always first run valid? or save or some such before trying to access errors. 

```
# let's see some of the many ways a record may fail to save!

class Person < ApplicationRecord
  validates :name, presence: true
end

>> p = Person.new
#=> #<Person id: nil, name: nil>
>> p.errors
#=> {}

>> p.valid?
#=> false
>> p.errors
#=> {:name=>["can't be blank"]}

>> p = Person.create
#=> #<Person id: nil, name: nil>
>> p.errors
#=> {:name=>["can't be blank"]}

>> p.save
#=> false

>> p.save!
#=> ActiveRecord::RecordInvalid: Validation failed: Name can't be blank

>> Person.create!
#=> ActiveRecord::RecordInvalid: Validation failed: Name can't be blank
```

### errors.full_messages

To get an array of human readable messages, call 
record.errors.full_messages.
```
>> p = Person.create
#=> #<Person id: nil, name: nil>
>> p.errors.full_messages
#=> ["Name can't be blank"]
```

### Built-in validators

Okay, but how do we actually start telling Active Record what to validate? Active Record offers many pre-defined validators that you can use dirctly inside your class definitions. These helpers provide common validation rules. Every time a validation fails, an error message is added to the object's errors collection, and this message is associated with the attribute being validated. 

There are many different validation helpers; we'll focus on the most common and important. Refer to the Rails guides or documentation for a totally comprehensive list. 

### presence

This one is the most common by far: the presence helper validates that the specified attributes are not empty. It uses the blank? method to check if the value is either nil or a blank string, that is, a string that is either empty or consists of only whitespace. 
```
class Person < ApplicationRecord
  # must have name, login, and email
  validates :name, :login, :email, presence: true
end
```
This demonstrates our first validation: we call the class method validates on our model class, giving it a list of column names to validate, then the validation type mapping to true. 

If you also want to be sure that an object associated with the class exists, you can do that too:
```
class LineItem < ApplicationRecord
  belongs_to :order

  validates :order, presence: true
end
```
Don't check for the presence of the foreign_key (order_id in this case); check the presence of the associated object (order). This will become useful later when we do nested forms. Until then, just develop good habits. 

The default error message for presence is "X can't be empty".

### uniqueness

This helper validates that the attribute's value is unique:
```
class Account < ApplicationRecord
  # no two Accounts with the same email
  validates :email, uniqueness: true
end
```
There is a very useful :scope option that you can use to specify other attributes that are used to limit the uniqueness check:
```
class Holiday < ApplicationRecord
  # no two Holidays with the same name for a single year
  validates :name, uniqueness: {
    scope: :year,
    message: 'should happen once per year'
  }
end
```
Notice how options for the validations can be passed as the value of the hash.

The default error message is "X has already been taken".

### Less common helpers

Presence and uniqueness are super-common. But there are some others that are often handy. Refer to the documentation for all the details. 

- format
    - Tests whether a string matches a given regular expression

- length
    - Tests whether a string or array has an appropriate length. Has options for minimum and maximum. 

- numericality; options include:
    - inclusion
        - "in" option lets you specify an array of possible values. All other values are invalid.

### Warning!

Rails 5 introduces a new behavior: it automatically validates the presence of belongs_to associations. To override this default behavior, we have to pass optional: true to the association initialization.

Lets look at an example. Say we have the following models:
```
class Home < ApplicationRecord
  has_many :cats,
    primary_key: :id,
    foreign_key: :home_id,
    class_name: :Cat
end

class Cat < ApplicationRecord
  belongs_to :home,
    primary_key: :id,
    foreign_key: :home_id,
    class_name: :Home
end
```
Let's assume that we want to allow for cats to be without a home. Because Rails 5 validates the presence of belongs_to associations, if we try to save a cat without a home, we'll get a validation error. 
```
cat = Cat.new
cat.save!
#=> (0.3ms)  BEGIN
# (0.4ms)  ROLLBACK
# ActiveRecord::RecordInvalid: Validation failed: Home must exist
```
In order to allow for homeless cats, we would have to include optional: true like so:
```
class Cat < ApplicationRecord
  belongs_to :home,
    primary_key: :id,
    foreign_key: :home_id,
    class_name: :Home,
    optional: true
end
```

### One more warning!

Because Rails 5 automatically validates the presence of our belongs_to associations, we can actually find ourselves in a bit of a tricky spot when also explicitly validating such an expression. Lets imagine that we want to have cats that belong to homes, and the presence of the home for each cat is in fact validated. Imagine we approached that by doing the following:
```
class Home < ApplicationRecord
  has_many :cats,
    primary_key: :id,
    foreign_key: :home_id,
    class_name: :Cat
end

class Cat < ApplicationRecord
  validates :home, presence: true

  belongs_to :home,
    primary_key: :id,
    foreign_key: :home_id,
    class_name: :Home
end
```
This seems like the right way to go about this, but in Rails 5, its not! By writing our own validation of validates :home, presence :true, we are actually validating it twice!
```
irb(main):001:0> c = Cat.new(name: 'Callie')
=> #<Cat id: nil, name: "Callie", home_id: nil, created_at: nil, updated_at: nil>
irb(main):002:0> c.save!
   (0.1ms)  begin transaction
   (0.1ms)  rollback transaction
ActiveRecord::RecordInvalid: Validation failed: Home can't be blank, Home must exist
```
This results in the printing out of two seperate error methods. In this case, "Home can't be blank" and "Home must exist". Printing both of these might cause users to get confused. Because of this we should refrain from validating our belong_to associations.

In short, the following would be preferrable:
```
class Home < ApplicationRecord
  has_many :cats,
    primary_key: :id,
    foreign_key: :home_id,
    class_name: :Cat
end

class Cat < ApplicationRecord
  belongs_to :home,
    primary_key: :id,
    foreign_key: :home_id,
    class_name: :Home
end
```

## Validations II: Custom Validations

When the built-in validation helpers are not enough for your needs, you can write your own validation method or validator classes.

### Custom methods

With validation methods, you can write your own method to validate a model. 
```
class Invoice < ApplicationRecord
  # validate tells the class to run these methods at validation time.
  validate :discount_cannot_be_greater_than_total_value

  private
  def discount_cannot_be_greater_than_total_value
    if discount > total_value
      errors[:discount] << 'can\'t be greater than total value'
    end
  end
end
```
Note that the presence of an error is registered by adding a messager to the errors hash. If no error messages are added, the validation is deemed to have passed. Note that the message does not mention the variable name; when you call full_messages, Rails will prefix the message with the attribute name for you. 

### errors.base

Sometimes an error is not specific to any one attribute. In this case, you add the error to errors[:base]. Since erros[:base] is an array, you can simply add a string to it and it will be used as an error message. 
```
class Person < ApplicationRecord
  def a_method_used_for_validation_purposes
    errors[:base] << 'This person is invalid because ...'
  end
end
```
### Custom Validators

Custom validators are classes that extend ActiveModel::EachValidator. Prefer writing a custom validator class when you want to reuse validation logic for multiple models or multiple columns. Otherwise, it's simpler to use a validator method. 

Your custom validator class must implement a validate_each method which takes three arguments: the record, the attribute name and its value. 

### if / unless

Sometimes it will make sense to validate an object only when a given predicate is satisfied. You may use the :if option when you want to specify when the validation SHOULD happen. If you want to specify when the validation SHOULD NOT happen, then you should use the :unless option. You can associate the :if and :unless options with a symbol corresponding to the name of a method that will get called right before validation happenes:
```
class Order < ApplicationRecord
  validates :card_number, presence: true, if: :paid_with_card?

  def paid_with_card?
    payment_type == 'card'
  end
end
```

## Indexing

Suppose we have a simple query:
```
SELECT *
FROM Users
WHERE Name = 'Mike'
```
Now think back to the discussion on Big-O and consider the time complexity for this query. If we have a table of 100 rows, its going to have to check every one of those rows for the name 'Mike'. This is referred to as "table scan" and is O(n) time complexity. Now imagine that we actually have ten millon users and that were making this query 100 times / second. This will really cause isssues!

It is important to index columns that are heavily used for lookups in queries. When you index a column, it creates a sorted data structure with pointers to the actual table. Since it's sorted, lookups can use binary search, which runs in O(log n) time. Log base 2 of 10 million is about 23, so this is much faster than performing our other "table scan".

Remember though, that indices do have a cost; they make INSERT, DELETE, and UPDATEs a little more taxing because the indices must be updated. 

As a side note, foreign_keys are pretty much always a good choice for indexing because they're frequently used in both WHERE clauses and in JOIN conditions, both f which can be incredibly taxing when not indexed. 

### Indexing a foreign_key

Now lets consider a practical examples:
```
class User < ApplicationRecord
  has_many :conversations, foreign_key: :user_id
end

class Conversation < ApplicationRecord
  belongs_to :user, foreign_key: :user_id
end  
```
Given a conversation, we can quickly lookup a User because users.id is the primary key, and the primary key is indexed by definition. But what about User#conversations. 

#conversations is matching on the foreign key column conversations.user_id. Only primary keys come indexed out of the box, so the generated query(SELECT * FROM conversations WHERE user_id = ?) will require a full table scan. With a lot of conversations, this could prove taxing!

The solution to this problem is to add an index in an ActiveRecord migration. We'll use the add_index method:
```
class AddUserIdIndexToConversations < ActiveRecord::Migration[5.1]
  def change
    add_index :conversations, :user_id
  end
end
```
Indexing can be useful for more than just speeding up our queries however. If we want to ensure that a column only holds unique values, we can provide the unique option to an index. 
```
class MakeUsernamesUnique < ActiveRecord::Migration[5.1]
  def change
    add_index :users, :username, unique: true
  end
end
```
We can even ensure the uniqueness of combinations of values, by passing an array instead of a single column name:
```
class EnsureUnique < ActiveRecord::Migration[5.1]
  def change
    add_index :conversations, [:user_id, :title], unique: true
  end
end
```
This ensures that there can be no more than one entry in the conversations table with the same user_id and title - useful if we want to allow multiple conversations to have the same title, but not for the same user. 
