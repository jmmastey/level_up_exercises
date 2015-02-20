require_relative 'load_dino'
require "pry"

module DinoDict

  OPTION = [:movement, :diet, :period, :size]

  def self.menu_printer(option)
    printer ||= {}
    printer[:movement] = "1) All dinosaurs that were bipeds"
    printer[:diet] = "2) All dinosaurs that were carnivores"
    printer[:period] = "3) Grab all dinosaurs in a specific period"
    printer[:size] = "4) Grab either small or big dinosaurs"

    option.each do |key|
      puts(printer.fetch(key))
    end
  end

  def self.convert_user_input(value)
    case value
    when 1
      [:movement]
    when 2
      [:diet]
    when 3
      [:period]
    when 4
      [:size]
    end
  end

  def self.user_input
    option = gets.chomp.to_i
    if (1..4).include?(option)
      option
    else
      raise ArgumentError
    end
  rescue ArgumentError
    puts "Please pick a valid option"
    retry
  end


  def self.chain
    puts "Would you like to chain another option? Y/N"
    user_selection = gets.chomp
    user_selection == 'Y' || user_selection == 'y'
  end

  def self.big?(size)
    size == "B" || size == "b"
  end

  def self.validate_movement(dino)
    dino.movement == 'Biped'
  end

  def self.validate_diet(dino)
    if dino.diet == "Carnivore" || dino.diet == "Piscivore" ||\
      dino.diet == "Insectivore"
        true
    else
      false
    end
  end

  def self.validate_period(period, dino)
    true if dino.period.select { |p| p =~ /#{period}/ }.any?
  end

  def self.evaluate_size(size, dino)
    if (size == 'S' || size == 's') && dino.weight.to_i < 2001
      true
    elsif (size == 'B' || size == 'b') && dino.weight.to_i > 2000
      true
    else
      false
    end
  end

  def self.evaluate_case(user_key, dino, period, size)
    case user_key
    when :movement
     return validate_movement(dino)
    when :diet
      return validate_diet(dino)
    when :period
      return validate_period(period, dino)
    when :size
      return evaluate_size(size, dino)
    end
  end

  def self.evaluate_dino(user_option, dinosaur, period, size)
    user_option.each do |key|
      unless evaluate_case(key, dinosaur, period, size)
        return false
      end
    end
    true
  end

  def self.find(user_option, dinosaurs, period, size)
    dinosaurs.dino_collection.each do |key, dino|
      if evaluate_dino(user_option, dino, period, size)
        print_dino(dino)
        dino.to_h
      end
    end
  end

  def self.print_dino(dinosaur)
    puts("Name: "+dinosaur.name.to_s)
    puts("Diet: "+dinosaur.diet.to_s) if dinosaur.diet!=nil
    puts("Weight: "+dinosaur.weight.to_s)if dinosaur.weight!=nil
    puts("Movement: "+dinosaur.movement.to_s) if dinosaur.movement != nil
    puts("Period: "+dinosaur.period_to_string.to_s)
    puts("Continent: "+dinosaur.continent.to_s) if dinosaur.movement != nil
    puts("Description: "+dinosaur.description.to_s) if dinosaur.description\
      != nil
    puts
  end

  def self.get_user_period(option)
    if option.include?(:period)
      puts 'Please enter the period'
      gets.chomp
    end
  end

  def self.get_user_size(option)
    if option.include?(:size)
      puts 'Please enter the size B/S'
      validate_size
    end
  end

  def self.validate_size
    size = gets.chomp
    raise SizeError unless size == 'B' || size == 'b' || size == 'S'\
      || size == 's'
      size
    rescue
      puts "Valid sizes are B/S. Please enter a valid size."
      retry
  end

  def self.output_json(output_file)
    File.open('dino.json', 'w') do |file|
      file.puts output_file
      puts "JSON output file dino.json has been created"
    end
  end

  def match_attribute(dino, attribute, key)
    attribute == dino.send(key.to_s)
  end

  def self.hash_search(params, dinosaurs)
puts (params.gsub(':', '=>'))
    search_terms = eval(params.gsub(':', '=>'))

    dinosaurs.dino_collection.each do |key, value|
      search_terms.each do |search_key, search_value|
        if search_key == 'period'
          next unless validate_period(search_value, value)
        else
          next unless match_attribute(value, search_value, search_key)
        end
        print_dino(value)
      end
    end
  end

  def self.main
    user_option = [:movement, :diet, :period, :size]
    dinosaurs = DinoCollection.new
    dinosaurs.african_dino_parser('african_dinosaur_export.csv')
    dinosaurs.normal_dino_parser('dinodex.csv')
    json_output = ""
    if ARGV.length == 0
      loop do
        DinoDict.menu_printer(user_option)
        input = convert_user_input(user_input)
        period = get_user_period(input)
        size = get_user_size(input)
        user_option -= input
        unless chain
          json_output += find((OPTION  - user_option), dinosaurs, period,\
            size).to_s
          break
        end
      end
    else
      hash_search(ARGV[0], dinosaurs)
    end
    output_json(json_output)
  end
end

DinoDict.main
