module Display

  PADDING = 20

  HEADER_NAMES = ["Name", "Period", "Continent", "Diet", "Weight (lbs)", "Walking", "Description"]

  def print_dinosaur_set(set)
    puts "\n\n"
    print_header
    puts ''
    set.each do |entry|
      print print_attribute(entry.name, PADDING)
      print print_attribute(entry.period, PADDING)
      print print_attribute(entry.continent, PADDING)
      print print_attribute(entry.diet, PADDING)
      print print_attribute(entry.weight_in_lbs, PADDING)
      print print_attribute(entry.walking, PADDING)
      print print_attribute(entry.description, PADDING)
      print "\n"
    end
  end

  def print_dinosaur_instance(set, name)
    entry = set.detect { |dinosaur| dinosaur.name.downcase =~ /#{name}/ }
    if entry
      puts "\nBelow is information on the dinosaur you entered:\n\n"
      print "Name".center(PADDING) if entry.name
      print "Period".center(PADDING) if entry.period
      print "Continent".center(PADDING) if entry.continent
      print "Diet".center(PADDING) if entry.diet
      print "Weight (lbs)".center(PADDING) if entry.weight_in_lbs
      print "Walking".center(PADDING) if entry.walking
      print "Description".center(PADDING) if entry.description
      puts ''
      print print_attribute(entry.name, PADDING) if entry.name
      print print_attribute(entry.period, PADDING) if entry.period
      print print_attribute(entry.continent, PADDING) if entry.continent
      print print_attribute(entry.diet, PADDING) if entry.diet
      print print_attribute(entry.weight_in_lbs, PADDING) if entry.weight_in_lbs
      print print_attribute(entry.walking, PADDING) if entry.walking
      print print_attribute(entry.description, PADDING) if entry.description
      print "\n"
    else
      puts "\nSorry, but I did not recognize that dinosaur name.\n"
    end
  end

  def print_attribute(attribute, padding)
    if attribute
      attribute.center(padding)
    else
      "---".center(padding)
    end
  end

  def print_header
    HEADER_NAMES.each { |header| print header.center(PADDING) }
  end

end
