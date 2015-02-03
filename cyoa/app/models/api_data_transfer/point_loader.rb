require './app/models/point'
require './app/models/api/lat_lon_zipcode_client'
require './app/helpers/private_attr_accessor'

module PointLoader
  extend PrivateAttrAccessor
  private_attr_accessor :response
  
  def initialize(zip_code_list)
    self.response = requester.new(zip_code_list)
    load_points
  end

  private

  def load_points
    response.each do |zipcode, lat_lon|
      point_model.new(lat:     lat_lon[0],
                      lon:     lat_lon[1],
                      zipcode: zipcode).save
    end
  end

  def requester
    LatLonZipcodeClient
  end

  def point_model
    Point
  end
end
