require 'json'
require 'face'
require 'csv'

class PhotosController < ApplicationController
  FILENAME = Rails.root.join('app', 'controllers','photos.csv') 
  API_KEY = 'aab4cf0d3e724b2fab4986c6a05696e3' 
  API_SECRET = 'f16c30aa0277468fb378f43533ab69a3'

  def new
    update_photos
  end

  def update_photos 
    client = Face.get_client(:api_key => 'aab4cf0d3e724b2fab4986c6a05696e3', :api_secret => 'f16c30aa0277468fb378f43533ab69a3')

  	@imported_photos = import_csv_file(FILENAME)
    @imported_photos.each do |i|
     
      my_face = client.faces_detect(:urls => [ i[:photo_url]], :attributes => 'all')

      p i[:first], i[:last], i[:photo_url]
      p my_face["photos"][0]["tags"][0]["attributes"]["happiness"]["confidence"]
      mood = my_face["photos"][0]["tags"][0]["attributes"]["mood"]["value"]
      happiness = my_face["photos"][0]["tags"][0]["attributes"]["happiness"]["confidence"]
      Photo.create( first: i[:first], last: i[:last], photo_url: i[:photo_url], mood: mood, happiness: happiness)
    end

    #p @raw_photos
    #client = Face.get_client(:api_key => 'aab4cf0d3e724b2fab4986c6a05696e3', :api_secret => 'f16c30aa0277468fb378f43533ab69a3')
    #my_face = client.faces_detect(:urls => ['https://lh3.googleusercontent.com/C8Zj-lDdfjl6dysDz4K9N2jobmoDJg1tKhNNz9X0U2X8=w475-h665-no'], :attributes => 'all')
    #p my_face["status"]
    #p my_face["photos"][0]["tags"][0]["attributes"]["happiness"]["confidence"]
    #newest = Photo.create( first: "Tracyy" , last: "Tangy", photo_url: "lfsdlf@dfdd.com")
  end
	
	def import_csv_file(filename)
    csv = []
    CSV.foreach( filename, headers: true, header_converters: :symbol) do |row|
      csv << row
    end
    csv
  end

  #def group_photos
  #  @raw_photos.map do |row|
  #    Photo.new(row)
  #  end
  #end

end



 