
module Helpers
  Addy = Struct.new(:street, :city, :zipcode)


  def address(text)
    data = Array(text.split("\n")) unless text.nil?
    raise(ScriptError, "No address information.") if data.blank?
    street = data.shift
    city, zipcode = data.shift.squish.split(" ")

    Addy.new(street, city, zipcode)

  end
end
