class Dinosaur

    attr_accessor :name, :period, :continent, :diet, :weight, :walking, :description
    attr_reader :csvrow

    def initialize(row)
        @name = row[:name]
        @period = row[:period]
        @continent = row[:continent]
        @diet = row[:diet]
        @weight = row[:weight]
        @walking = row[:walking]
        @description = row[:description]
        @csvrow = row
    end

    def matches_any? criteria
        if (@csvrow.key? criteria.keys.first)
            true if @csvrow.fetch( criteria.keys.first) == criteria[criteria.keys.first] 
        else 
            false
        end

    end

    def to_s
        puts "Dinosaur Info \n
            Name: #{@name} Period: #{@period} Continent: #{@continent} Diet: #{@diet} \n
            Weight: #{@weight} Walking: #{@walking} Description: #{@description}"
    end

end
