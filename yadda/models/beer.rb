class Beer < ActiveRecord::Base
  has_many :ratings
  belongs_to :brewery
  belongs_to :beer_style
end
