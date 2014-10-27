module Display

def print_dinosaur_set(set)
    puts "Name".center(20) + "Period".center(20) + "Continent".center(20) + "Diet".center(20) + "Weight (lbs)".center(20) + "Walking".center(20) + "Description".center(20)
    puts ''
    set.each do |entry|
      print print_attribute(entry.name, 20)
      print print_attribute(entry.period, 20)
      print print_attribute(entry.continent, 20)
      print print_attribute(entry.diet, 20)
      print print_attribute(entry.weight_in_lbs, 20)
      print print_attribute(entry.walking, 20)
      print print_attribute(entry.description, 20)
      print "\n"
    end
  end

  def print_attribute(attribute, padding)
    if attribute
      attribute.center(padding)
    else
      "---".center(padding)
    end
  end

end
