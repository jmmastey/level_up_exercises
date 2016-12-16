class Legislator < ActiveRecord::Base
  paginates_per 50
  has_many :bills
end
