module Api
  module V1
    class PlaneComponentResource < JSONAPI::Resource
      has_one :plane
      has_one :component

      attributes :installation_date, :log
      filters :installation_date, :log
    end
  end
end
