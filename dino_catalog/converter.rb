class Converter
  # This method exists to call other conversions should they be necessary.
  # This seems useful to me because in my setup_options() in dinodex.rb,
  # I don't want to have to pass in multiple method calls. This keeps the
  # interface consistent and less subject to change. So even though this
  # is planning ahead a bit, it seems a useful bit of planning ahead.
  def self.dino_data_convert
    carnivore_convert
  end

  def self.carnivore_convert
    lambda do |value, field|
      if field[:header].to_s == 'diet'
        diet_type(value) || value
      else
        value
      end
    end
  end

  def self.diet_type(diet_value)
    value = diet_value.to_s.downcase
    if value == 'yes'
      'Carnivore'
    elsif value == 'no'
      ''
    end
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
