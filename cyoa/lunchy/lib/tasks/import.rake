require 'foursquare_client'

namespace :import do
  desc "Imports food venues using the Foursquare API"
  task venues: :environment do
    # Maximum search radius in meters. We'll set the radius large enough
    # to hit the northeast corner of the loop.
    MAX_RADIUS = 1200

    puts "Creating FoursquareClient..."
    client = FoursquareClient.new
    new_venues = 0

    puts "Searching for restaurants within #{MAX_RADIUS}m radius..."
    items = client.find_all_restaurants(MAX_RADIUS)
    items.each do |item|
      venue = Venue.new
      venue.venue_id = item[:venue_id]
      venue.name = item[:name]
      venue.street = item[:street]
      venue.distance = item[:distance]
      venue.rating = item[:rating]
      venue.url = item[:url]
      venue.category_name = item[:category]
      venue.category_icon_prefix = item[:icon_prefix]
      venue.category_icon_suffix = item[:icon_suffix]

      if venue.valid?
        venue.save 
        new_venues += 1
      end
    end

    puts "#{new_venues} new venue(s) found"
  end
end
