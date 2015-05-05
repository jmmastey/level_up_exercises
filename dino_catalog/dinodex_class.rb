require './dino_class.rb'

class DinoDex
    def initialize(dino_arry)
        @dino_array = dino_arry
    end

    def run_user_interface()
        @filter_query = {:name => "", :period => "" , :continent => "", :diet => "", :weight => "", :walking => ""}
        keys = ["name", "period", "continent", "diet", "weight", "walking"]
        keys.each { |k| prompt_user_for_filter(k)}
        p @filter_query
        #p @filter_query[0]
        #filter_dinos(@filter_query[0])
    end

    def prompt_user_for_filter(filter_name)
        puts "Would you like to view dinosaurs by #{filter_name}? Y/N"
        values = Array.new
        if gets.chomp.downcase == 'y'
            puts "Choose the number of the #{filter_name} you wish to view:"
            get_all_values(filter_name).each_with_index do |val,i| 
                puts "#{i+1}. #{val}\n"
                values << val
            end
            users_selection = values[gets.chomp.to_i - 1]
            p filter_name.to_sym
            @filter_query[filter_name.to_sym] = users_selection
            
            p users_selection
        end
    end


   # def filter_dinos(filter)
    #    p filter[0]
    



    def filter_dinos(filter_params)
        matching_dinos = Array.new
        @dino_array.each  do |i|
            #  puts i.all_info
            if i.all_info.include?(filter_params)
                matching_dinos << i.name
               # puts i.name, " is a #{filter_params}"
            else
               # puts i.name, " is not a #{filter_params}"
            end

          #  if i.walking.include?("Biped") 
          #      #p i
          #      puts i.name, " is a biped"
          #  else
                #p i
         #     puts i.name, " not biped"
         #   end
        end
    matching_dinos
    end

    def get_all_values(key)
        values = Array.new
        @dino_array.each do |i|
            values << i.send(key)
        end
    values.uniq
    end 
end



