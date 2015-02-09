require './app/models/point'
require './app/models/api/lat_lon_zipcode_client'

module PointLoader
  def self.load(zip_code_list)
    zip_code_list_for_load = zip_code_list_not_in_db(zip_code_list)
    unless zip_code_list_for_load.empty?
      call_api_and_load(zip_code_list_for_load)
    end
  end

  private

  def self.call_api_and_load(zip_code_list)
    response = call_api(zip_code_list)
    response.each do |zip, lat_lon|
      point_model.new(lat: lat_lon[0],
                      lon: lat_lon[1],
                      zip: zip).save
    end
  end

  def self.zip_code_list_not_in_db(zip_code_list)
    zip_code_list.split(" ").each_with_object([]) do |zip, not_in_db|
      not_in_db << zip if point_model.where(zip: zip).empty?
    end.join(" ")
  end

  def self.call_api(zip_code_list)
    requester.new.request(zip_code_list)
  end

  def self.requester
    LatLonZipcodeClient
  end

  def self.point_model
    Point
  end
end

