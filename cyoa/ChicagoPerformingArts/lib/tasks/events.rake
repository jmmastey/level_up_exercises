namespace :events do
  desc "TODO"
  task pull_events: :environment do
    require 'open-uri'
    require 'json'

    api_key = "n4asu6brgvf7jnzek46u3uw6"
    api_url = "http://api.amp.active.com/v2/search"

    i = 1
    loop do
      params = {
        query: "painting",
        start_date: "2015-01-01..",
        near: "chicago,IL,US",
        radius: "50",
        api_key: api_key,
        current_page: i,
      }

      uri = URI.parse(api_url)
      uri.query = URI.encode_www_form(params)
      events_uri = JSON.parse (open(uri).read)

      events_uri["results"].each do |results|
        @events = Event.new
        @events.placename = results['place']['placeName'] if results['place']['placeName'].present?
        @events.cityname = results['place']['cityName']
        @events.activity_start_date = results['activityStartDate']
        @events.activity_end_date = results['activityEndDate']
        @events.sales_status = results['salesStatus']
        @events.registration_url_adr = results['registrationUrlAdr']
        @events.save
      end
      i += 1
      break if events_uri["results"].empty?
    end

    desc "TODO"
    task destroy_all_events: :environment do
      Event.destroy_all
    end

  end
end
