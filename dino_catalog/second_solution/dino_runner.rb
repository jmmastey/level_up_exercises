require_relative "dinosaurs"

class DinoRunner
  attr_reader :dino_catalog

  def initialize
    @dino_catalog = Dinosaurs.from_directory
  end

  def run
    greeting_display
    command = ["help"]
    while true
      case command[0]
      when "-e", "exit"
        break
      when "-h", "help"
        options_display
      when "-l", "list"
        dino_catalog.display
      when "-b", "big"
        dino_catalog.big_dinosaurs.display
      when "-c", "carnivorus"
        dino_catalog.carnivorus_dinosaurs.display
      when "-2", "biped"
        dino_catalog.biped_dinosaurs.display
      when "-p", "period"
        dino_catalog.dinosaurs_from(command[1]).display
      when "-f", "filter"
        filter_catalog(command[1..-1]).display
      when "-s", "search"
        search_terms = parse_search_terms(command[1..-1])
        dino_catalog.search(search_terms).display
      end
      print "Dino Request: "
      command = gets.chomp.split(" ")
    end
  end

  def filter_catalog(filter_terms)
    dinosaurs = dino_catalog.clone
    filter_terms.each do |term|
      case term      
      when "-b", "big"
        dinosaurs = dinosaurs.big_dinosaurs.clone
      when "-c", "carnivorus"
        dinosaurs = dinosaurs.carnivorus_dinosaurs.clone
      when "-2", "biped"
        dinosaurs = dinosaurs.biped_dinosaurs.clone
      end
    end
    dinosaurs

    # #this doesn't work but the above does
    # #pretty sure this is b/c of the clone but not super clear on why
    # filter_terms.each_with_object(dino_catalog.clone) do |term, dinosaurs|
    #   case term      
    #   when "-b", "big"
    #     dinosaurs = dinosaurs.big_dinosaurs.clone
    #   when "-c", "carnivorus"
    #     dinosaurs = dinosaurs.carnivorus_dinosaurs.clone
    #   when "-2", "biped"
    #     dinosaurs = dinosaurs.biped_dinosaurs.clone
    #   end
    # end
  end

  def parse_search_terms(search_terms)
    search_terms.each_with_object({}) do |term, query_hash|
      search_pair = term.split(":")
      query_hash[search_pair[0].downcase] = search_pair[1].downcase
    end
  end

  def options_display
    puts "-h or help: access this help menue"
    puts "-e or exit: exit the program"
    puts "-l or list: view a list of all dinos"
    puts "-b or big: view a list of dino >= 4000lb"
    puts "-c or carnivorus: view a list of all non-plant eating dinosaurs"
    puts "-2 or biped: view a list of all bipedal dinosaurs"
    puts "-p or period <period>: view a list of dinosaurs from the <period> period"
    puts "-f or filter <big/biped/carnivorus or their abbreviations>: view a listed filtered by all included criteria"
    puts "-s or search category:<term> category:<term>... : view a list of dinos filtered by search criteria"
  end

  def greeting_display
    puts "Welcome to Di-Facto, your presumed source for prehistoric points of interest"
  end

  private
  attr_reader :dino_catalog

end

defacto = DinoRunner.new
defacto.run