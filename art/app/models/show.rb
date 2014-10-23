class Show < ActiveRecord::Base
  has_and_belongs_to_many :performers
  has_many :performances

  validates :name, presence: true
  validates :description, presence: true
end
