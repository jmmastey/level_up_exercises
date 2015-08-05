class Search < ActiveRecord::Base
  belongs_to :search_set
  has_many :shows
end
