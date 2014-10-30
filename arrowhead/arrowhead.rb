class Arrowhead
  # This seriously belongs in a database.
  CLASSIFICATIONS = {
    far_west: {
      notched: "Archaic Side Notch",
      stemmed: "Archaic Stemmed",
      lanceolate: "Agate Basin",
      bifurcated: "Cody",
    },
    northern_plains: {
      notched: "Besant",
      stemmed: "Archaic Stemmed",
      lanceolate: "Humboldt Constricted Base",
      bifurcated: "Oxbow",
    },
  }

  @user_messages =
  {
    unknown_region: "Unknown region, please provide a valid region.",
    unknown_shape: "Unknown shape value. Are you sure you know what you're talking about?",
    describe_arrowhead: "You have a(n) '%s' arrowhead. Probably priceless.",
  }

  def self.classify(region, shape)
    arrowhead = select_arrowhead_by_shape(shape, get_region_shapes(region))
    print_arrowhead(arrowhead)
  end

  def self.print_arrowhead(arrowhead)
    puts user_message(:describe_arrowhead, arrowhead)
  end
  private_class_method :print_arrowhead

  def self.get_region_shapes(region)
    CLASSIFICATIONS[region] || raise(user_message(:unknown_region))
  end
  private_class_method :get_region_shapes

  def self.select_arrowhead_by_shape(shape, region_shapes)
    region_shapes[shape] || raise(user_message(:unknown_shape))
  end
  private_class_method :select_arrowhead_by_shape

  def self.user_message(message_sym, *a)
    format(@user_messages[message_sym], *a)
  end
  private_class_method :user_message
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
