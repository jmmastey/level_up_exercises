class Artist < ActiveRecord::Base
  validates :name, presence: true
end
