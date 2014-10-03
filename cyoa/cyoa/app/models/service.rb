class Service < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :url, presence: true, uniqueness: true
end
