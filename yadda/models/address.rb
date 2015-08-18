class Address < ActiveRecord::Base
  has_many :addresses
  has_many :users
end
