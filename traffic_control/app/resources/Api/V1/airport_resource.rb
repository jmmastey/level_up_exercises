module Api
  module V1
    class AirportResource < JSONAPI::Resource
      attributes :code, :city, :capacity
      filters :code, :city, :capacity
    end
  end
end

