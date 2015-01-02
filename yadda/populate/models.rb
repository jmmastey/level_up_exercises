require "active_record"

class Address < ActiveRecord::Base
  has_many :breweries
end

class Beer < ActiveRecord::Base
  belongs_to :brewery
  has_many :ratings
  has_many :reviews
end

class Brewery < ActiveRecord::Base
  belongs_to :address
  has_many :beers
end

class Rating < ActiveRecord::Base
  belongs_to :beer
  belongs_to :user
end

class Review < ActiveRecord::Base
  belongs_to :beer
  belongs_to :user
end

class User < ActiveRecord::Base
  has_many :ratings
  has_many :reviews
end
