module Dino_Methods

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
        
    def menu(dinos)
        option = [1,2,3,4]
        user_option = []
        @size = nil
        @period = nil
        loop do      
            option_temp = option
            option_temp = option_temp - user_option
            print_menu(option_temp)
            temp = gets.chomp.to_i
            if temp < 1 ||temp > 4
                puts("Please pick a valid option")
                next
            else
                user_option << temp
                case temp
                when 3
                    puts("Please enter the period")
                    @period = gets.chomp
                when 4
                    loop do
                        puts("Big or small? B/S")
                        @size = gets.chomp
                        if @size == 'B' || @size == 'b'
                            @size = 'Big'
                            break
                        elsif @size == 'S' || @size == 's'
                            @size = 'Small'
                            break
                        else
                            puts("Please enter a valid size B/S")
                        end
                    end
                end
                if user_option.length < 4
                    puts("Would you like to chain another option Y/N")
                    user_selection = gets.chomp
                end
                if user_selection == 'Y'
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
        if dinosaur.period_prefix != nil
            puts("Period: "+dinosaur.period_prefix+" "+dinosaur.period)
        else
            puts("Period: "+dinosaur.period)
        end
        puts("Diet: "+dinosaur.diet) if dinosaur.diet!=nil
        puts("Weight: "+dinosaur.weight.to_s)if dinosaur.weight!=nil
        puts("Movement: "+dinosaur.movement) if dinosaur.movement != nil
        puts("Continent: "+dinosaur.continent)
        puts("Description: "+dinosaur.description) if dinosaur.description != nil
        puts
    end        

    def search(dino, option, period, size)
        @json = nil
        dino.each do |key, dinosaur|
            @flag = false
            option.each do|indx|
                case indx
                when 1
                    if  dinosaur.movement == 'Biped'
                        @flag = true
                    else
                        @flag = false
                    end
                when 2
                    if dinosaur.diet == 'Carnivore'||dinosaur.diet == 'Insectivore'||dinosaur.diet == 'Piscivore'
                        @flag = true
                    else
                        @flag = false
                    end                        
                when 3 
                    if dinosaur.period == period
                        @flag = true
                    else
                        @flag = false
                    end
                when 4
                    if size == 'Small' && dinosaur.weight.to_i <= 2000
                        @flag = true
                    elsif size == 'Big' && dinosaur.weight.to_i > 2000
                        @flag = true
                    else
                        @flag = false
                    end
                end
            end
            if @flag == true
                print_dino(dino.fetch(key))
                @json = @json .to_s + dino.fetch(key).to_json
            end
        end
        File.open('output.json', 'w') do |file|
            file.puts @json
            puts "JSON output file output.json has been created"
        end
    end
end
                
                        
    
                    
                
        
