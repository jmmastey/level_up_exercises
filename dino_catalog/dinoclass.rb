class DinoDex
	def initialize(raw_data)
        dinos=Array.new 
        raw_data.each_with_index do |row, i|
           #arry[i]=Dino.new(row)
            dinos[i]=Dino.new(row[:name], row[:period])
        end           
        dinos.each do |j| 
            p j.name 
            p j.period 
        end
    end
  
    def ask_questions
    end

	def find(filter_params)
    end 
end


class Dino
	#attr_accessor :genus, :period, :continent, :carnivore, :weight, :walking, :description
    attr_reader :name, :period
    #def initialize(genus, period, continent, carnivore, weight, walking, description)
    
    def initialize(name_info, period_info )
        #p all_info
        #puts "#{all_info[:name]}#{all_info[:genus]}"
        #p all_info
        @name=name_info
        @period=period_info
    end

end
