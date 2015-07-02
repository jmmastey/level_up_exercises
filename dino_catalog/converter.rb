class Converter
  def self.dino_data_convert
    carnivore_convert
  end

  def self.carnivore_convert
    lambda do |value, field|
      diet_type = value
      if field[:header].to_s == 'diet'
        diet_value = value.to_s.downcase
        if diet_value =~ /yes|no/
          diet_value == 'yes' ? diet_type = 'Carnivore' : diet_type = ''
        end
      end
      diet_type
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
