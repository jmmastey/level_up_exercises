module VenuesHelper
  def foursquare_path(venue)
    "https://foursquare.com/venue/#{venue.venue_id}"
  end

  ICON_SIZES = { :icon_small => 32, :icon_big => 64 }

  def icon_for(venue, size = ICON_SIZES[:icon_big])
    icon_url = "#{venue.category_icon_prefix}#{size}#{venue.category_icon_suffix}"
    image_tag(icon_url, alt: venue.name, class: "venue-icon-#{size}")
  end
end
