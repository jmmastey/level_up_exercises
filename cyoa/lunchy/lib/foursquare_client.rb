require 'foursquare2'
require 'json'

class FoursquareClient
  # For ease of use, these API keys are included here. For a production app
  # these would not be stored in the source code.
  CLIENT_ID = "MDGZ40QG4A2RKN125M0QUFSWLFV03JKG3MVQYV1JSDOE2SJL"
  CLIENT_SECRET = "A3C2VFXVEA10R0PLXA2LPHNZWEXBQPMA4WOZ40AOY0SWZGIJ"

  API_VERSION = "20150326"

  # The API allows this many results to returned per call
  MAX_RESULTS = 50

  # Lat/Long for 200 W Jackson Blvd, Chicago, IL
  # TODO: Make this configurable
  LAT = 41.878214
  LONG = -87.634353

  # This is Foursquare's section parameter for "food" venues
  SECTION_FOOD = "food"

  def initialize
    @client = Foursquare2::Client.new(
      client_id: CLIENT_ID,
      client_secret: CLIENT_SECRET,
    )
  end

  def find_all_restaurants(max_distance, results_desired = 0)
    options = api_options(max_distance, results_desired)
    fetch_all_results(options, results_desired)
  end

  def api_options(max_distance, num_results)
    {
      v: API_VERSION,
      ll: "#{LAT},#{LONG}",
      radius: max_distance,
      section: SECTION_FOOD,
      limit: (num_results > 0 ? num_results : MAX_RESULTS),
      price: "1,2,3,4",
      sortByDistance: 1
    }
  end

  def fetch_all_results(options, results_desired)
    fetch_init(results_desired)

    loop do
      items_remaining = fetch_group(options)
      options[:offset] = @total_fetched if items_remaining > 0
      break if items_remaining == 0
    end

    @parsed_results.flatten
  end

  def fetch_init(results_desired)
    @parsed_results = []
    @total_desired = results_desired
    @total_fetched = 0
    @offset = 0
  end

  # Fetches one group of venues and returns the number remaining
  def fetch_group(options)
    results = @client.explore_venues(options)

    # If we want all possible results, we need to wait for the result
    # from the first API call to get the total results available
    @total_desired = results_total(results) if @total_desired == 0
    @parsed_results << parse_results(results)
    results_remaining(results)
  end

  def results_total(results)
    results.totalResults
  end

  def results_returned(results)
    results.groups.first.items.length
  end

  def results_remaining(results)
    @total_fetched += results_returned(results)
    @total_desired - @total_fetched
  end

  def parse_results(results)
    # Although there can technically be any number of groups, the
    # API currently returns only a single "recommended" group
    items = results.groups.first.items
    items.map { |item| to_h(item) }
  end

  def to_h(item)
    venue = item.venue
    {
      venue_id: venue.id,
      name: venue.name,
      street: venue.location.address,
      distance: venue.location.distance,
      rating: venue.rating,
      url: venue.url,
      category: venue.categories.first.name,
      icon_prefix: venue.categories.first.icon.prefix,
      icon_suffix: venue.categories.first.icon.suffix,
    }
  end
end
