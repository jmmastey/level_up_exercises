require "dinosaur"
require "dinodex_loader"
require "dinodex_filter"

class DinodexController
  def initialize(output)
    @output = output
    @dinosaurs = []
    @dinodex_filter = DinodexFilter.new
  end

  def dinosaurs
    @dinosaurs ||= []
  end

  def csv_files
    @csv_files ||= []
  end

  def start(directory)
    @output.puts "Finding CSV files in #{directory}"
    @dinodex_loader = DinodexLoader.new
    @csv_files = @dinodex_loader.find_csv_files(directory)
    @csv_files.each do |file|
      @dinodex_loader.load_csv_file("#{directory}/#{file}").each { |dino| @dinosaurs.push(dino)}
    end
  end

  def interaction_loop
    @output.puts "Welcome to Dinodex"

    begin
      @output.puts "Enter your selection: (h for help)"
      selection = gets.chomp
      case selection[0]
        when "d"
          filter_and_detail("name=#{selection[2..-1]}")
        when "k"
          key_display
        when "l"
          list_display
        when "f"
          filter_and_display(selection[2..-1])
        when "g"
          filter_and_detail(selection[2..-1])
        when "j"
          filter_and_json(selection[2..-1])
        when "q"
          @output.puts "Goodbye"
        when "?", "h"
          help_display
        else
          @output.puts "invalid selection, try again"
      end
      @output.puts ""
    end while selection != "q"

  end

  def help_display
    @output.puts <<-MENU
d [name]          detailDisplay    show all details of the dinosaur [name],
                                   "d Abrictosaurus"
f [key=value]|... filterAndDisplay show the names of the dinosaurs that have the matching
                                   key and value, "f walking=biped". Multiple with pipe
                                   delimiting, like "f walking=biped|diet=omnivore"
g [key=value]|... filterAndDetail  same as "f", but shows details instead of just name
j [key=value]|... filterAndJSON    same as "f", but shows JSON
k                 keyDisplay       show all the dinosaur attributes for filtering
l                 listDisplay      show all dinosaur names
q                 quit
?, h              help
    MENU
  end

  def key_display
    @output.puts "Keys available: name, period, diet, weight, walking, description, continent"
  end

  def list_display(dinosaurs = @dinosaurs)
    dinosaurs.each do |dinosaur|
      @output.puts dinosaur.name
    end
  end

  def detail_display_by_name(name)
    dinosaur = @dinosaurs.select { |dinosaur| dinosaur.name.downcase == name.downcase }[0]
    if !dinosaur.nil?
      detail_display(dinosaur)
    else
      @output.puts "Dinosaur with name '#{name}' not found."
    end

  end

  #TODO: have string and object inputs?
  def detail_display(dinosaur)
    @output.puts dinosaur.name
    @output.puts "Period: #{dinosaur.period}" if !dinosaur.period.nil?
    @output.puts "Diet: #{dinosaur.diet}" if !dinosaur.diet.nil?
    @output.puts "Walking: #{dinosaur.walking}" if !dinosaur.walking.nil?
    @output.puts "Description: #{dinosaur.description}" if !dinosaur.description.nil?
    @output.puts "Continent: #{dinosaur.continent}" if !dinosaur.continent.nil?
  end

  def filter_and_display(criteria)
    list_display(@dinodex_filter.get_filtered_list(@dinosaurs, criteria))
  rescue ArgumentError => e
    @output.puts e.message
  end

  def filter_and_detail(criteria)
    @dinodex_filter.get_filtered_list(@dinosaurs, criteria).each { |dinosaur| detail_display(dinosaur) }
  rescue ArgumentError => e
    @output.puts e.message
  end

  def filter_and_json(criteria)
    @output.puts JSON::dump(@dinodex_filter.get_filtered_list(@dinosaurs, criteria))
  rescue ArgumentError => e
    @output.puts e.message
  end

end
