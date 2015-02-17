class Legislator < ActiveRecord::Base
  has_many :good_deeds
  has_many :users, through: :favorites
end
