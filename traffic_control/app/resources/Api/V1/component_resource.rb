module Api
  module V1
    class ComponentResource < JSONAPI::Resource
      attributes :name
      filters :name
    end
  end
end
