require_relative "file_handler"
require_relative "dinosaur"

class AfricanFile < FileHandler
  def map_to_object(content)
    dino = Dinosaur.new(content)
    dino.continent = 'Africa'
    dino
  end

  def header_converters
    CSV::HeaderConverters[:renaming] = lambda do |header|
      header = :name if header == 'Genus'
      header = :diet if header == 'Carnivore'
      header.downcase.to_sym
    end
  end

  def content_converters
    CSV::Converters[:blank_to_nil] = lambda do |field, field_info|
      field && field.empty? ? nil : field

      field = diet_type(field) if field_info[:header].to_s == 'diet'

      field
    end
  end

  def diet_type(carnivore)
    if carnivore == 'Yes'
      'Carnivore'
    else
      'Herbivore'
    end
  end
end
