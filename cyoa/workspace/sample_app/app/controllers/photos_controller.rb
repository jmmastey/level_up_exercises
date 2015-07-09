require 'json'
require 'face'
require 'csv'

class PhotosController < ApplicationController
  FILENAME = Rails.root.join('app', 'controllers', 'photos.csv')
  API_KEY = 'aab4cf0d3e724b2fab4986c6a05696e3'
  API_SECRET = 'f16c30aa0277468fb378f43533ab69a3'

  def new
    
    @all_moods = { happy: "happiness", sad: "sadness", angry: "anger",
                  surprised: "surprise", disgusted: "disgust", scared: "fear" }
    update_photos
    @selected_mood = @all_moods[:surprised]
    sort_photos(@selected_mood)
  end

  def update_photos
    client = Face.get_client(api_key: API_KEY, api_secret: API_SECRET)
    import_csv_file(FILENAME).each do |i|
      unless Photo.exists?(photo_url: i[:photo_url])
        my_face = client.faces_detect(urls: [i[:photo_url]], attributes: 'all')
        attrib = my_face["photos"][0]["tags"][0]["attributes"]
        mood = attrib["mood"]["value"]
        moods = {first: i[:first], last: i[:last], photo_url: i[:photo_url]}
        @all_moods.each_value do |v|
          moods[v.to_sym] = attrib[v]["confidence"]
        end
        moods[:mood] = mood
        Photo.create(moods)
      end
    end
  end

  def import_csv_file(filename)
    csv = []
    CSV.foreach(filename, headers: true, header_converters: :symbol) do |row|
      csv << row
    end
    csv
  end

  def sort_photos(attribute)
    attrib_hash = { attribute.to_sym => :desc }
    @matching_photos = Photo.order(attrib_hash)
    #@matching_photos = Photo.where(mood: 'happy').order(happiness: :desc)
  end
end