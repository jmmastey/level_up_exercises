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
    @selected_mood = @all_moods[:happy]
    sort_photos(@selected_mood)
  end

  def update_photos
    import_csv_file(FILENAME).each do |i|
      unless Photo.exists?(photo_url: i[:photo_url])
        store_photo_attributes(i)
      end
    end
  end

  def import_csv_file(filename)
    csv = []
    CSV.foreach(filename, headers: true, header_converters: :symbol) { |row| csv << row }
    csv
  end

  def store_photo_attributes(photo_id)
    detected_moods = run_api_call(photo_id)
    Photo.create(detected_moods)
  end

  def run_api_call(id)
    client = Face.get_client(api_key: API_KEY, api_secret: API_SECRET)
    my_face = client.faces_detect(urls: [id[:photo_url]], attributes: 'all')
    attrib = my_face["photos"][0]["tags"][0]["attributes"]
    moods = { first: id[:first], last: id[:last], photo_url: id[:photo_url],
               mood: attrib["mood"]["value"] }
    @all_moods.each_value { |v| moods[v.to_sym] = attrib[v]["confidence"] }
    moods
  end

  def sort_photos(attribute)
    attrib_hash = { attribute.to_sym => :desc }
    @matching_photos = Photo.order(attrib_hash)
    #@matching_photos = Photo.where(mood: 'happy').order(happiness: :desc)
  end
end