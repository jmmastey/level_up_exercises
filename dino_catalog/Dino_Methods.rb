module Dino_Methods

$OPTION = [1,2,3,4]

require 'json'    

  def print_menu(option)
    printer = Hash.new
    printer[1] = "1) All dinosaurs that were bipeds"
    printer[2] = "2) All dinosaurs that were carnivores"
    printer[3] = "3) Grab dinosaurs by time period"
    printer[4] = "4) Grab dinosaurs by size" 
    puts("What would you like to search by?")
    for i in option
      puts(printer.fetch(i))
    end
  end
  
  def get_period
    puts("Please enter the period")
    period = gets.chomp
  end
  
  def get_size
    puts("Big or Small? B/S")
    loop do 
      size = gets.chomp
      if size == 'B' || size == 'b'
        size = 'Big'
        break
      elsif size == 'S' || size == 's'
        size = 'Small'
        break
      else
        puts("Valid sizes are B/S Please re-enter an appropriate size")  
      end
    end
    size
  end

  def get_user_selection
    puts("Would you like to chain another option Y/N")
    user_selection = gets.chomp
    if user_selection == 'Y'|| user_selection == 'y'
    end
  end
    
      
  def menu(dinos)
    user_option = []
      @size = nil
      @period = nil
      loop do      
      option_temp = option_temp - user_option
      print_menu(option_temp)
      temp = gets.chomp.to_i
      if temp < 1 || temp > 4
        puts("Please pick a valid option")
        next
      else
        user_option << temp
        case temp
          when 3
            @period = get_period
          when 4
            @size = get size
        end
      end
        if user_option.length < 4
          if get_user_selection
            next
          else
            search(dinos, user_option, @period, @size)
            user_option = []
          end
        end
      end
  end
    
  def print_dino(dinosaur)
    puts("Name: "+dinosaur.name)
    puts("Diet: "+dinosaur.diet) if dinosaur.diet!=nil
    puts("Weight: "+dinosaur.weight.to_s)if dinosaur.weight!=nil
    puts("Movement: "+dinosaur.movement) if dinosaur.movement != nil
    puts("Continent: "+dinosaur.continent)
    puts("Description: "+dinosaur.description) if dinosaur.description != nil
    puts
  end        

  def match_period(dino, period)
    dino.period.each do |index|
      if dino.period[index].include? period
        @flag = true
      end
    end
    @flag ||= false
  end

  def match_size(dinosaur, size)
    @flag = (size == 'Small' && dinosaur.weight.to_i <= 2000 ) || (size == 'Big' && dinosaur.weight.to_i > 2000)
  end

  def search(dino, option, period, size)
    @json = nil
    dino.each do |key, dinosaur|
      @flag = false
      option.each do|indx|
        case indx
        when 1
          @flag = (dinosaur.movement == 'Biped')
        when 2
          @flag = (dinosaur.diet == 'Carnivore'||dinosaur.diet == 'Insectivore'||dinosaur.diet == 'Piscivore')
        when 3 
          @flag = match_period(dinosaur, period)
        when 4
          @flag = match_size(dinosaur, size)
        end
      end
      if @flag 
        print_dino(dino.fetch(key))
        @json = @json .to_s + dino.fetch(key).to_json
      end
    end
    File.open('output.json', 'w') do |file|
      file.puts @json
      puts "JSON output file output.json has been created"
    end
  end
  def split_period period
    unless /(.+)\sor\s(.+)/.match(period)
      @period << dino['PERIOD']
    else
      @period << Regexp.last_match(1)
      split_period Regexp.last_match(2)
    end
  end 
end
                
                        
    
                    
                
        
