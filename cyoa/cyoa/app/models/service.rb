class Service < ActiveRecord::Base
  has_many :charts
  has_many :metrics

  validates :name, presence: true, uniqueness: true
  validates :url, uniqueness: true
end
