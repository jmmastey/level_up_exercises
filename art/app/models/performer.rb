class Performer < ActiveRecord::Base
  has_and_belongs_to_many :shows

  validates :name, presence: true
  validates :description, presence: true
end
