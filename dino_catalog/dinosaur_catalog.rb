require 'colorize'
require './dinosaur'

class DinosaurCatalog

  def initialize()
    @dinosaurs = []
  end

  def successfully_called?(routine, args)
    begin
      method(routine).call(args)
    rescue RuntimeError => msg
      puts msg
    end
  end
  
  def <<(more_dinosaurs)
    @dinosaurs += more_dinosaurs
  end

  def periods
    periods = {}
    @dinosaurs.each do |dinosaur|
      era  = dinosaur.period.split.last
      name = dinosaur.name
      
      periods[era] ||= []
      periods[era].push name
    end
    periods
  end

  def get_name(choice)
    tokens = choice.split
    raise "Must provide a dinosaur name\n".red if tokens.count < 2
    tokens[1]
  end

  def parse_criterion(token)
    criterion = token.split("=")
    raise "Invalid token format (".red + token.blue + "), expecting \"key=Value\"\n".red unless criterion.count == 2
    criterion
  end

  def get_search_criteria(choice)
    tokens = choice.split
    tokens.shift
    tokens.map { |token| parse_criterion(token) }
  end

  def write_matched(criteria)
    matched = @dinosaurs.select { |dinosaur| dinosaur.matches?(criteria) }
    matched.each { |dinosaur| puts dinosaur.name }
    puts "#{matched.size} Found\n".yellow
  end

  def write_header(name)
    puts name.light_blue
    puts ("-" * name.length).light_blue
  end

  def display_fields
    write_header("Fields")
    Dinosaur.get_fields.each { |field| puts field }
    puts
  end

  def display_names
    write_header("Names")
    @dinosaurs.each { |dinosaur| puts dinosaur.name }
    puts
  end

  def display_bipeds
    write_header("Bipeds")
    @dinosaurs.each { |dinosaur| puts dinosaur.name if dinosaur.is_biped? }
    puts
  end

  def display_carnivores
    write_header("Carnivores")
    @dinosaurs.each { |dinosaur| puts dinosaur.name if dinosaur.is_carnivore? }
    puts
  end

  def organize_by_period
    write_header("Periods")
    periods.each do |era, names|
      puts era
      names.each { |name| puts "   - " + name }
      puts
    end
  end

  def display_heavy_weights
    write_header("Heavyweights")
    @dinosaurs.each { |dinosaur| puts dinosaur.name if dinosaur.is_heavy? }
    puts
  end

  def display_welter_weights
    write_header("Welterweights")
    @dinosaurs.each { |dinosaur| puts dinosaur.name unless dinosaur.is_heavy? }
    puts
  end

  def display_dinosaur(choice)
    return unless name = successfully_called?(:get_name, choice)

    matched = @dinosaurs.select { |dinosaur| dinosaur.name == name }
    matched.each { |dinosaur| puts dinosaur }

    puts "Sorry, can't find this dinosaur: ".red + "#{name}" if matched.empty?
    puts
  end

  def get_filename(choice)
    tokens = choice.split
    raise "Must provide a file name\n".red if tokens.count < 2

    filename = tokens[1]
    raise "File already exists, please remove or change name: ".red + " #{filename}\n\n" if File.exists?(filename)

    filename
  end

  def to_json
    dump = Hash.new
    dump["Dinosaurs"] = @dinosaurs.map { |dinosaur| dinosaur.to_h }
    dump.to_json
  end

  def write_to_file(filename, str)
    begin
      File.write(filename, str)
      puts "Wrote File: " + filename
    rescue
      puts "Encountered an issue while trying to write to file: ".red + filename
    end
  end

  def export_to_JSON(choice)
    return unless filename = successfully_called?(:get_filename, choice)
    write_to_file(filename, to_json)
    puts
  end

  def search_dinosaur(choice)
    return unless criteria = successfully_called?(:get_search_criteria, choice)

    write_header("Search Results")
    write_matched(criteria)
  end
end
