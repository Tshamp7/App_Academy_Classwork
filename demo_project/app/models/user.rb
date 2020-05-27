# == Schema Information
#
# Table name: users
#
#  id            :bigint           not null, primary key
#  name          :string           not null
#  date_of_birth :date             not null
#  user_name     :string           not null
#  karma         :integer          default(0)
#
class User < ApplicationRecord

end
