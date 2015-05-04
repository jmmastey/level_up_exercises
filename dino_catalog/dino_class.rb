class Dino
    attr_reader :all_info, :name, :period, :continent, :diet, :weight, :walking, :description
    
    def initialize(dino_row)    
        @all_info=dino_row.to_s
        @name=dino_row[:name]
        @period=dino_row[:period]
        @continent=dino_row[:continent]
        @diet=dino_row[:diet]
        @weight=dino_row[:weight]
        @walking=dino_row[:walking]
        @description=dino_row[:description]
    end

end
