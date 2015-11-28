require_relative "dino_catalog"

class DinoCommandLineInterface
  def initialize
    @dino_catalog = DinoCatalog.new
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
        display_collection(dino_catalog.dino_collection)
      when "-b", "big"
        display_collection(dino_catalog.big_dinosaurs)
      when "-c", "carnivorus"
        display_collection(dino_catalog.carnivorus_dinosaurs)
      when "-2", "biped"
        display_collection(dino_catalog.biped_dinosaurs)
      when "-p", "period"
        display_collection(dino_catalog.dinosaurs_from(command[1]))
      when "-f", "filter"
        command[1..-1].map(&:downcase).each do |filter_term|

          
        # collection = dino_catalog.dino_collection        
        # if filter_criteria.include?("-c") || filter_criteria.include?("carnivorus")
        #   collection = dino_catalog.carnivorus_dinosaurs(collection)
        # end
        # if filter_criteria.include?("-b") || filter_criteria.include?("big")
        #   collection = dino_catalog.big_dinosaurs(collection)
        # end
        # if filter_criteria.include?("-2") || filter_criteria.include?("biped")
        #   collection = dino_catalog.biped_dinosaurs(collection)
        # end
        display_collection(collection)

      when "-s", "search"
        search_terms = parse_search_terms(command[1..-1])
        display_collection(dino_catalog.search(search_terms))
      end
      print "Dino Request: "
      command = gets.chomp.split(" ")
    end
  end

  def display_collection(collection)
    collection.each do |item|
      puts item
    end
  end

  def parse_search_terms(search_terms)
    rtn = {}
    search_terms.each do |term|
      search_pair = term.split(":")
      rtn[search_pair[0].downcase] = search_pair[1].downcase
    end
    rtn
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


defacto = DinoCommandLineInterface.new
defacto.run