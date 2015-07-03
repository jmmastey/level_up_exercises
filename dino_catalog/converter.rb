class Converter
  def self.dino_data_convert
    carnivore_convert
  end

  def self.carnivore_convert
    lambda do |value, field|
      field[:header].to_s == 'diet' ? diet_type(value) || value : value
    end
  end

  def self.diet_type(diet_value)
    diet_value = diet_value.to_s.downcase
    diet_value == 'yes' ? 'Carnivore' : '' if diet_value =~ /yes|no/
  end

  def self.header_convert
    lambda do |header|
      header.downcase!
      rename_columns(header)
      header.to_sym
    end
  end

  def self.rename_columns(header)
    header.gsub!('genus', 'name')
    header.gsub!('weight_in_lbs', 'weight')
    header.gsub!('walking', 'movement')
    header.gsub!('carnivore', 'diet')
  end
end
