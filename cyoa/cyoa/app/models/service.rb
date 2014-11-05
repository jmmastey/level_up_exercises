class Service < ActiveRecord::Base
  has_many :charts
  has_many :metrics

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
