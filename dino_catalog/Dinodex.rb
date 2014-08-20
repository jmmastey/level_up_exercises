class Dinoparser

    require "CSV"

    attr_reader :dinos

    def initialize(filename = nil)
        parse_file(filename)
    end


    def parse_file(filename) 
        @dinos = CSV.read(filename, { headers: true })
    end
 

    def find_dinosaurs(criteria)
        if criteria.empty?
                      
        else
            find_with_criteria(criteria)
        end


                        
    end

    def find_with_criteria(criteria)
        criteria.each do | key, value |
            @dinos.select do | row |
                if row[key] == value 
                    values = split_string(row.to_s)
                    values.each do | k, v |
                        k = k.upcase

                        if (criteria.key? find_value_in_key(criteria, "WEIGHT"))
                            puts "test"
                            puts "#{k}: #{v}" if (row[criteria.fetch("WEIGHT")] > criteria.fetch("WEIGHT"))
                        else
                            puts "#{k}: #{v}" if v.length > 1
                        end
                    end
                end
            end
        end
    end


    def split_string(string)
        values = @dinos.headers.zip(string.split(","))
    end

    def find_value_in_key(key, textToFind)
        key.select {|k, _| k.include? textToFind.upcase}
    end


end

d1 = Dinoparser.new("dinodex.csv")
#d1.find_dinosaurs({"WALKING" => "Biped", "DIET" => "Carnivore", "WEIGHT" => 7000})
d1.find_dinosaurs({"WALKING" => "Quadriped"})
