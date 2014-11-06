require 'csv'

CSV::HeaderConverters[:weight_converter] = lambda do |header|
  header.downcase.include?("weight_in_lbs") ? "weight" : header
end

CSV::Converters[:diet_converter] = lambda do |row_value|
 # if row_value=="Yes" || row_value=="No"
  if row_value == "Yes"
   "Carnivore"
  elsif row_value == "No"
   "Herbivore"
 else
   row_value
 end
 # end
end


CSV::HeaderConverters[:carnivore_converter] = lambda do |header|
  header.downcase.include?("carnivore") ? "diet" : header
end

CSV::HeaderConverters[:name_converter] = lambda do |header|
  header.downcase.include?("genus") ? "name" : header
end


