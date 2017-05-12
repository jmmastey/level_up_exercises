
module Helpers
  Addy = Struct.new(:street, :city, :zipcode)

  def address(text)
    data = Array(text.split("\n")) unless text.nil?
    raise(ScriptError, "No address information.") if data.blank?
    street = data.shift
    city, zipcode = data.shift.squish.split(" ")

    Addy.new(street, city, zipcode)
  end

  def find_venue_url(detail)
    case detail
      when /www./ && /http:/  then detail
      when /www./ && !/http:/ then "http://#{detail}"
      else nil
    end
  end

  def showtime(date, time)
    Time.zone = "US/Central"
    Time.zone.parse("#{date} #{time}").to_datetime
  end
end
