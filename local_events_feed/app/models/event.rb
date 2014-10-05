class Event < ActiveRecord::Base
  validates :name, presence: true
  validates :location, presence: true
  validates :time, presence: true
  has_and_belongs_to_many :users

  def match?(other)
    name == other.name && location == other.location && time == other.time
  end

  def has_match_in?(list)
    list.any? { |other| other.match?(self) }
  end
end
