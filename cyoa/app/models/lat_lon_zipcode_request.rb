require 'nori'
require 'savon'
#require './app/models/nws_request.rb'

class LatLonZipcodeRequest #< NWSRequest
  extend Savon::Model

  client wsdl: "http://graphical.weather.gov/xml/DWMLgen/wsdl/ndfdXML.wsdl", convert_request_keys_to: :camelcase

  # client = Savon.client do 
  #   wsdl: "http://graphical.weather.gov/xml/DWMLgen/wsdl/ndfdXML.wsdl"
  #   convert_request_keys_to :camelcase
  # end

  operations :lat_lon_list_zip_code

  def self.lat_lon_list_zip_code(zip_code_list)
    super(message: { zip_code_list: zip_code_list })
  end

  def self.response(body)
    body.values[0]
  end

  def self.parse_parameters(response)
    parser = Nori.new
    response.each_pair {  }
    parser.parse(body)

  end
end