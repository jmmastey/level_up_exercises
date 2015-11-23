module Api
  module V1
    class PassengerResource < JSONAPI::Resource
      has_many :flights

      attributes :name, :seating_preference, :meal_preference
      filters :name, :seating_preference, :meal_preference
    end
  end
end
