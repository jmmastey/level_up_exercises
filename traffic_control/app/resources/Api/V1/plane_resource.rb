module Api
  module V1
    class PlaneResource < JSONAPI::Resource
      has_one :plane_type
      has_many :flights
      has_many :plane_components
    end
  end
end
