class Show < ActiveRecord::Base
  has_and_belongs_to_many :performers
  has_many :performances

  validates :name, presence: true
  validates :description, presence: true
  validates :location, presence: true
  validates :year, presence: true, numericality: true
  validates :director, presence: true
  validates :theatre_company, presence: true
  validates :notes, presence: true

  default_scope -> { order("name asc") }
end
