class Converter
  # NOTE TO REVIEWER:
  # This method was brought up as being unnecessary and probably good to
  # remove. This method exists to call other conversions should they be
  # necessary. This seems like good design to me because in my setup_options()
  # in dinodex.rb I don't want to have to pass in multiple method calls for
  # different converters. Instead I always just call the one below. This keeps
  # the interface consistent and less subject to change. So even though this
  # is planning ahead a bit, it seems a useful bit of planning ahead.
  # Thoughts?
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
    # NOTE FOR REVIEWER:
    # A previous review suggested refactoring this to use guard
    # clauses due to efficiency concerns. Below may not be the most
    # efficient means but, as far as I can see, it is the means
    # necessary to return the information correctly. Calling
    # Converter.header_convert must lead to a Proc with the changed
    # header values. Attempts to use guard clauses will not pass the
    # correct values into the header_converters. It's critical that
    # the names be replaced in the header that is passed back to
    # Converter.header_convert. I'm open to ideas.
    header.gsub!('genus', 'name')
    header.gsub!('weight_in_lbs', 'weight')
    header.gsub!('walking', 'movement')
    header.gsub!('carnivore', 'diet')
  end
end
