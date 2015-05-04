require './dino_class.rb'

class DinoDex
    def initialize(dino_arry)
        @dino_array = dino_arry
    end

    def get_matching_dinos(filter_params)
        @dino_array.each  do |i|
            #  puts i.all_info
            if i.all_info.include?(filter_params)
                puts i.name, " is a #{filter_params}"
            else
                puts i.name, " is not a #{filter_params}"
            end

          #  if i.walking.include?("Biped") 
          #      #p i
          #      puts i.name, " is a biped"
          #  else
                #p i
         #     puts i.name, " not biped"
         #   end
        end

    end
end




