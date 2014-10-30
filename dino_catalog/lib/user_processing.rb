module UserProcessing

  SEARCH_REGEX = {
    bipeds: /biped/,
    carnivores: /carnivore|insectivore|piscivore/,
    periods: /cretaceous|permian|jurassic|oxfordian|albian|triassic/,
    sizes: /big|small/
  }

  def obtain_user_filters
    @filtered_dinosaurs = nil
    print UserPrompts::USER_SEARCH_PROMPT
    print '> '
    user_input = gets.chomp.downcase
    exit! if user_input == 'exit' || user_input == 'quit'
    search_terms = get_user_search_terms(user_input)
    @filtered_dinosaurs = filter_results(@catalog, search_terms)
    puts "\nYour search resulted in #{@filtered_dinosaurs.size} dinosaurs:"
    print_search_summary(@filtered_dinosaurs)
    user_processing(@filtered_dinosaurs)
  end

  def get_user_search_terms(phrase)
    search_terms = {}
    SEARCH_REGEX.each do |term, regex|
      search_terms[term] = phrase.scan(regex) unless phrase.scan(regex).empty? #  use inject?
    end
    search_terms
  end

  def user_processing(dinosaurs)
    print UserPrompts::USER_PROCESSING_PROMPT
    print '> '
    user_input = gets.chomp.downcase
    exit! if user_input == 'exit' || user_input == 'quit'
    user_actions(user_input)
  end

  def user_actions(input)
    exit! if input == 'exit' || input == 'quit'
    if input == 'print'
      print_dinosaur_set(@filtered_dinosaurs)
      user_processing(@filtered_dinosaurs)
    elsif input == 'search'
      launch!(@csv_filename)
    elsif input == 'json'
      convert_to_json(@filtered_dinosaurs)
      puts "\nYour JSON file has been saved as json_export.json in the main directory."
      user_processing(@filtered_dinosaurs)
    else
      print_dinosaur_instance(@filtered_dinosaurs, input)
      user_processing(@filtered_dinosaurs)
    end
  end

end
