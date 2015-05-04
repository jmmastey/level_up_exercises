class DinoDex
	def initialize(raw_data)
        @dinos=Array.new 
        raw_data.each_with_index do |row, i|
            if row[:genus]!=nil
                row[:name]=row[:genus]
            end
            if row[:continent]==nil
                row[:continent]="Africa"
            end
            if row[:carnivore]!=nil
                row[:diet]="Carnivore"
            end
            @dinos[i]=Dino.new(row[:name], row[:period], row[:continent], row[:diet], row[:weight], row[:walking], row[:description])
        end           
        @dinos.each do |j| 
            p j.name 
            p j.period 
            p j.continent
            p j.diet
            p j.weight
            p j.walking
            p j.description
        end
    end
  
    def ask_questions
    end

	def find(filter_params)
    end 
end


class Dino
    attr_reader :name, :period, :continent, :diet, :weight, :walking, :description
    
    def initialize(name_info, period_info, continent_info, diet_info, weight_info, walking, description )
        #p all_info
        @name=name_info
        @period=period_info
        @continent=continent_info
        @diet=diet_info
        @weight=weight_info
        @walking=walking
        @description=description
    end

end
