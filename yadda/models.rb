class Address < ActiveRecord::Base
  has_many :addresses
  has_many :users
end

class Beer < ActiveRecord::Base
  has_many :ratings
  belongs_to :brewery
  belongs_to :beer_style
end

class BeerStyle < ActiveRecord::Base
  has_many :beers
end

class Brewery < ActiveRecord::Base
  belongs_to :address
  has_many :beers
end

class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :beer
end

class User < ActiveRecord::Base
  belongs_to :address
  has_many :ratings
end
