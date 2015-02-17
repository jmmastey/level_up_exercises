class Favorite < ActiveRecord::Base
  belongs_to :legislator
  belongs_to :user
end
