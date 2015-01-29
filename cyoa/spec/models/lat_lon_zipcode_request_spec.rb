require 'savon'
require './app/models/lat_lon_zipcode_request.rb'

describe LatLonZipcodeRequest do
  it "gets latitude and longitude list from the body" do
    body = {:lat_lon_list_zip_code_response=>{:list_lat_lon_out=>"<?xml version='1.0'?><dwml version='1.0' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xsi:noNamespaceSchemaLocation='http://graphical.weather.gov/xml/DWMLgen/schema/DWML.xsd'><latLonList>41.837,-87.685</latLonList></dwml>", :"@xmlns:ns1"=>"http://graphical.weather.gov/xml/DWMLgen/wsdl/ndfdXML.wsdl"}}
  end

  it "returns the correct latitude and longitude for one zipcode" do
    zip_code_list = "60606"
    response = LatLonZipcodeRequest.lat_lon_list_zip_code(zip_code_list)
    puts response.body
    #expect(response).to eq("41.8818,87.6367")
  end


end
