class Brewery < ActiveRecord::Base
  belongs_to :address
  has_many :beers
end
