class Tag < ActiveRecord::Base
  has_many :user_tags
  has_many :users

  has_many :bill_tags
  has_many :bills, through: :bill_tags
end
