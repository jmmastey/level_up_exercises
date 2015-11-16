require "interactor"

class SearchLocuVenues
  include Interactor

  def call
    context.merchants = create_merchants(venues)
  end

  private

  def build_location(location_data)
    return nil unless location_data

    street = location_data[:address1]
    street += "\n#{location_data[:address2]}" if location_data[:address2]

    coords = location_data[:geo].try(:[], :coordinates)

    Location.find_or_create_by(
      street:    street,
      city:      location_data[:locality],
      state:     location_data[:region],
      zip:       location_data[:postal_code],
      latitude:  coords[0],
      longitude: coords[1]
    )
  end

  def create_merchants(venues)
    venues.map do |venue|
      Merchant.find_or_create_by(external_id: venue[:locu_id]) do |m|
        m.name = venue[:name]
        m.phone = venue[:contact].try(:[], :phone)
        m.location = build_location(venue[:location])
      end
    end
  end

  def venues
    response = context.client.search_venues(search_params)
    response = HashWithIndifferentAccess.new(response)

    response[:venues]
  end

  def search_params
    {
      location: { postal_code: context.postal_code },
      fields: [ :locu_id, :name, :description, :location, :contact, :categories,
                :menus, :website_url ],
    }
  end
end
