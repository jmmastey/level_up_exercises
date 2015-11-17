require "interactor"

class SearchLocuVenues
  include Interactor

  def call
    create_merchants(venues)
  end

  private

  def build_location(location, location_data)
    return nil unless location_data

    Location.new.tap do |location|
      location.street = location_data[:address1]
      location.street += "\n#{location_data[:address2]}" if location_data[:address2]

      location.city = location_data[:locality]
      location.state = location_data[:region]
      location.zip = location_data[:postal_code]

      coords = location_data[:geo].try(:[], :coordinates)
      location.latitude = coords.try(:[], 0)
      location.longitude = coords.try(:[], 1)
    end
  end

  def create_menu_items(menu, sections)
    sections.each do |section|
      group = section[:section_name]

      section[:subsections].each do |subsection|
        subgroup = subsection[:subsection_name]

        subsection[:contents].each do |item|
          menu_item = menu.menu_items.find_or_initialize_by(menu_group: group,
                                                            menu_subgroup: subgroup,
                                                            name: item[:name])

          menu_item.description = item[:description]
          menu_item.price = item[:price]
          menu_item.save
        end
      end
    end
  end

  def create_menus(merchant, menus)
    return nil unless menus

    menus.map do |menu|
      db_menu = merchant.menus.find_or_create_by(name: menu[:menu_name]) do |m|
        m.price_unit = menu[:currency_symbol]
      end

      create_menu_items(db_menu, menu[:sections])
    end
  end

  def create_merchants(venues)
    Merchant.transaction do
      context.merchants = venues.map do |venue|
        Merchant.find_or_initialize_by(external_id: venue[:locu_id]).tap do |m|
          break m if m.recently_updated?

          m.name = venue[:name]
          m.phone = venue[:contact].try(:[], :phone)
          m.description = venue[:description]
          m.website_url = venue[:website_url]
          m.location = build_location(m.location, venue[:location])
          m.save || Rails.logger.error("Unable to save merchant #{m.inspect}")

          create_menus(m, venue[:menus])
        end
      end
    end
  end

  def venues
    response = context.client.search_venues(search_params)
    response = HashWithIndifferentAccess.new(response)

    response[:venues] || []
  end

  def search_params
    {
      categories: "food",
      location: { postal_code: context.postal_code },
      menus: { "$present" => true },
    }
  end
end
