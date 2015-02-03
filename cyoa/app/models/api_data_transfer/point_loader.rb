require './app/models/point'
require './app/models/api/lat_lon_zipcode_client'
require './app/helpers/private_attr_accessor'

module PointLoader
  def load(zip_code_list)
    zip_code_list_for_load = zip_code_list_not_in_db(zip_code_list)
    unless zip_code_list_for_load.empty?
      call_api_and_load(zip_code_list_for_load)
    end
  end

  private

  def call_api_and_load(zip_code_list)
    response = call_api(zip_code_list)
    response.zip_code_lat_lon.each do |zipcode, lat_lon|
      point_model.new(lat:     lat_lon[0],
                      lon:     lat_lon[1],
                      zipcode: zipcode).save
    end
  end

  def zip_code_list_not_in_db(zip_code_list)
    zip_code_list.split(" ").each_with_object([]) do |zip, not_in_db|
      not_in_db << zip if point_model.find(zipcode: zipcode).empty?
    end.join(" ")
  end

  def call_api(zip_code_list)
    requester.new.request(zip_code_list)
  end

  def requester
    LatLonZipcodeClient
  end

  def point_model
    Point
  end
end
