module Display

def print_dinosaur_set(set)
    puts "\n\n"
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

  def print_dinosaur_instance(set, name)
    entry = set.detect { |dinosaur| dinosaur.name.downcase =~ /#{name}/ }
    puts "\nBelow is information on the dinosaur you entered:\n\n"
    print "Name".center(20) if entry.name
    print "Period".center(20) if entry.period
    print "Continent".center(20) if entry.continent
    print "Diet".center(20) if entry.diet
    print "Weight (lbs)".center(20) if entry.weight_in_lbs
    print "Walking".center(20) if entry.walking
    print "Description".center(20) if entry.description
    puts ''
    print print_attribute(entry.name, 20) if entry.name
    print print_attribute(entry.period, 20) if entry.period
    print print_attribute(entry.continent, 20) if entry.continent
    print print_attribute(entry.diet, 20) if entry.diet
    print print_attribute(entry.weight_in_lbs, 20) if entry.weight_in_lbs
    print print_attribute(entry.walking, 20) if entry.walking
    print print_attribute(entry.description, 20) if entry.description
    print "\n"
  end

  def print_attribute(attribute, padding)
    if attribute
      attribute.center(padding)
    else
      "---".center(padding)
    end
  end

end
