require 'savon'

module NWSClient
  WSDL = "http://graphical.weather.gov/xml/DWMLgen/wsdl/ndfdXML.wsdl"
  REQUEST_KEYS = :lower_camelcase
end
