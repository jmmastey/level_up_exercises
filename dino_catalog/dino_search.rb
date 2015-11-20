require 'pry'
require_relative 'dinodex.rb'

class DinoSearch
  attr_accessor :dinodex

  def initialize
    @dinodex = Dinodex.new([])
    @dinodex.african_dino_import
    @dinodex.dino_import
  end


  def create_json(dinosaur_data)
    @dinodex.export_to_json("export#{Time.now.strftime("%FT%R")}.json", dinosaur_data)
    puts "\n JSON successfully exported!"
  end

  def print_dino_results
    puts @results
  end

  def export_query_option
    puts "\n Type 'Y' if you would like to export your query."
    user_input = gets.chomp.upcase
    create_json(@results) if user_input == "Y"
  end

  def valid_period?(user_input)
    @available_periods = @dinodex.master_dinosaur_list.map(&:period).uniq
    @available_periods.include?(user_input)
  end

  def print_dinosaurus_instructions
    l_width = 60
    puts "\n"
    puts ("USER INSTRUCTIONS:".center(l_width))
    puts ("::SEARCHING:: \n •Enter a menu number.  \n •Your search will continue to chain off one another as you go; \n •For example, if you search for 'Carnivores' and then 'Bipeds' your final search will include all dinosaurs that are Carnivores *and* Bipeds.  \n •Your search will continue to build off of itself unless you reset your search results.".ljust(l_width/2))
    puts ("\n ::EXPORTING:: \n •After each query you will be prompted with the option to export that specific query. \n •If you want to export your results at the end you may do so by hitting the menu option. \n •You may also view all dinosaur data, and an export of all the dinosaur data is available upon choosing that menu option.")
    puts ("\n ::RESETTING:: \n •If you want to reset your results and begin a new series of queries just hit the menu option for reset.".ljust(l_width/2))
    puts ("\n ::QUITTING:: \n •Choose the 'Exit' option on the menu.".ljust(l_width/2))
  end

  def print_menu_options
    l_width = 40
    puts ("\n Welcome to Dinosaurus!  Choose your adventure:".center(l_width))
    puts "\n"
    puts ("DINOSAURUS MENU OPTIONS \n".center(l_width))
    puts ("SEARCH:".ljust(l_width/2) + "TYPE THE FOLLOWING:".rjust(l_width/2))
    puts ("Instructions".ljust(l_width/2) + "1".rjust(l_width/2))
    puts ("Bipeds".ljust(l_width/2) + "2".rjust(l_width/2))
    puts ("Carnivores".ljust(l_width/2) + "3".rjust(l_width/2))
    puts ("Period".ljust(l_width/2) + "4".rjust(l_width/2))
    puts ("Big (> 2 Tons)".ljust(l_width/2) + "5".rjust(l_width/2))
    puts ("Small (< 2 Tons)".ljust(l_width/2) + "6".rjust(l_width/2))
    puts ("Export Results".ljust(l_width/2) + "7".rjust(l_width/2))
    puts ("View All Dino Data".ljust(l_width/2) + "8".rjust(l_width/2))
    puts ("Reset Search Results".ljust(l_width/2) + "9".rjust(l_width/2))
    puts ("Exit".ljust(l_width/2) + "10".rjust(l_width/2))
  end

  def start
    begin
      @results ||= @dinodex
      print_menu_options
      user_input = gets.chomp.to_i
      case user_input
        when 1
          print_dinosaurus_instructions
        when 2
          @results = @results.biped_search
          print_dino_results
          export_query_option
        when 3
          @results = @results.carnivore_search
          print_dino_results
          export_query_option
        when 4
          l_width = 40
          puts "Which period? Choose:"
          puts ("Cretaceous".ljust(l_width/2))
          puts ("Jurassic".ljust(l_width/2))
          puts ("Albian".ljust(l_width/2))
          puts ("Oxfordian".ljust(l_width/2))
          puts ("Late Permian".ljust(l_width/2))
          user_input = gets.chomp
          if valid_period?(user_input)
            @results = @results.period_search(user_input)
            print_dino_results
            export_query_option
          else
            puts "That's not a valid period."
          end
        when 5
          @results = @results.big
          print_dino_results
          export_query_option
        when 6
          @results = @results.small
          print_dino_results
          export_query_option
        when 7
          create_json(@results)
        when 8
          @results = @dinodex
          print_dino_results
          export_query_option
        when 9
          @results = @dinodex
      else
        puts "Please choose a valid menu option." unless user_input == 10
      end
    end while user_input != 10
  end
end
