class SearchSet < ActiveRecord::Base
  belongs_to :channel
  has_many :searches
end
