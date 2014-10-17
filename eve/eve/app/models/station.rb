class Station < ActiveRecord::Base
  has_many :orders
end
