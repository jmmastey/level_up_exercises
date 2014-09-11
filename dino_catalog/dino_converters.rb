require 'csv'

CSV::Converters[:nil_or_downcase] = lambda do |field|
  field && field.empty? ? nil : field.downcase
end

CSV::Converters[:african_diet_converter] = lambda do |field, field_info|
  return field unless field_info[:header].downcase.eql? :diet

  case field.downcase
  when "yes" 
    "carnivore"
  when "no" 
    "herbivore"
  else 
    field
  end
end

CSV::HeaderConverters[:weight_converter] = lambda do |header|
  header.downcase.include?("weight") ? "weight" : header
end

CSV::HeaderConverters[:african_converter] = lambda do |header|
  head = header.downcase
  if head.include?("genus")
    "name"
  elsif head.include?("carnivore")
    "diet"
  else
    header
  end
end

