module Api
  module V1
    class PlaneTypeResource < JSONAPI::Resource
      has_many :planes

      attributes :name, :seat_count
      filters :name, :seat_count
    end
  end
end
