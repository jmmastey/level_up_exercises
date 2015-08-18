class Beer < ActiveRecord::Base
  has_many :ratings
  belongs_to :brewery
end
