require 'savon'

class NWSRequest
  extend Savon::Model

  client = Savon.client do
    wsdl: "http://graphical.weather.gov/xml/DWMLgen/wsdl/ndfdXML.wsdl"
    convert_request_keys_to :camelcase
  end
end