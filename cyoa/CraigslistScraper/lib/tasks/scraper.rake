namespace :scraper do
  desc "Fetch Craigslist posts from 3taps"
  task scrape: :environment do
    require 'open-uri'
    require 'json'
  
    auth_token = "a23f2c2436dfcac948390a3c5b5d4b33"
    polling_url = "http://polling.3taps.com/poll"
 
    loop do 
      params = {
        auth_token: auth_token,
        anchor: Anchor.first.value,
        source: "CRAIG",
        category_group: "RRRR",
        category: "RHFR",
        'location.state' => "USA-IL",
        retvals: "location,external_url,heading,body,timestamp,price,images,annotations"
      }
     
      uri = URI.parse(polling_url)
      uri.query = URI.encode_www_form(params)
   
      result = JSON.parse(open(uri).read)
   
      #puts JSON.pretty_generate result["postings"].first["images"]
      
      result["postings"].each do |posting|
        @post = Post.new
        @post.heading = posting["heading"]
        @post.body = posting["body"]
        @post.price = posting["price"]
        @post.neighborhood = Location.find_by(code: posting["location"]["locality"]).try(:name)
        @post.external_url = posting["external_url"]
        @post.timestamp = posting["timestamp"]
        @post.bedrooms = posting["annotations"]["bedrooms"] if posting["annotations"]["bedrooms"].present?
        @post.bathrooms = posting["annotations"]["bathrooms"] if posting["annotations"]["bathrooms"].present?
        @post.sqft = posting["annotations"]["sqft"] if posting["annotations"]["sqft"].present?
        @post.cats = posting["annotations"]["cats"] if posting["annotations"]["cats"].present?
        @post.dogs = posting["annotations"]["dogs"] if posting["annotations"]["dogs"].present?
        @post.w_d_in_unit = posting["annotations"]["w_d_in_unit"] if posting["annotations"]["w_d_in_unit"].present?
        @post.street_parking = posting["annotations"]["street_parking"] if posting["annotations"]["street_parking"].present?
        
        @post.save
        
        #loop over images and save to db
        posting["images"].each do |image|
          @image = Image.new
          @image.url = image["full"]
          @image.post_id = @post.id
          @image.save
        end
      end

      Anchor.first.update(value: result["anchor"])
      puts Anchor.first.value
      break if result["postings"].empty?
    end
  end

  desc "Destroy all posting data"
  task destroy_all_posts: :environment do
    Post.destroy_all
  end
  
  desc "Save neighborhood codes in a reference table"
  task scrape_neighborhoods: :environment do
    require 'open-uri'
    require 'json'
  
    auth_token = "a23f2c2436dfcac948390a3c5b5d4b33"
    location_url = "http://reference.3taps.com/locations"
  
    params = {
      auth_token: auth_token,
      level: "locality",
      state: "USA-IL"
    }
   
    uri = URI.parse(location_url)
    uri.query = URI.encode_www_form(params)
 
    result = JSON.parse(open(uri).read)
 
    #puts JSON.pretty_generate result
    
    result["locations"].each do |location|
      @location = Location.new
      @location.code = location["code"]
      @location.name = location["short_name"]
      @location.save
    end
  end

end
