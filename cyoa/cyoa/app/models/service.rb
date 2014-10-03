class Service < ActiveRecord::Base
  has_many :charts

  validates :name, presence: true, uniqueness: true
  validates :url, presence: true, uniqueness: true
end
