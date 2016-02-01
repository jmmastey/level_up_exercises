require_relative './joes_csv_parser.rb'
require_relative './afro_dino_parser.rb'

joes_parser = JoesCsvParser.new(File.join(File.dirname(__FILE__),'dinodex.csv'))
afro_parser = AfroDinoParser.new(File.join(File.dirname(__FILE__),'african_dinosaur_export.csv'))

@parsers = [joes_parser, afro_parser]
@parsed_data = {"weight" => {"small" => [], "big" => []}, "bipeds" => [], 
  "periods" => {}, "carnivores" => []}


def parse_and_print_info(criteria)
  criteria.each do |criterion|
    @parsers.each do |parser|
      classified_data = parser.send("classify_by_#{criterion}")
      if(!(["weight", "periods"].include?(criterion)))
        @parsed_data[criterion] << classified_data
      elsif(criterion == "weight")
        classified_data.each do |k, v|
          @parsed_data[criterion][k.to_s] += classified_data[k]
        end
      elsif(criterion == "periods")
        classified_data.each do |k, v|
          if(@parsed_data[criterion][k.to_s])
            @parsed_data[criterion][k.to_s] += v
          else
            @parsed_data[criterion][k.to_s] = v
          end
        end
      end
    end
  end
  @parsed_data.each do |k, v| 
    print_dinosaurs(k,@parsed_data[k])    
  end
end

def print_dinosaurs(message, data)
  puts ":#############{message.upcase}############"
  if(data.is_a?(Array))
    data.each do |element|
      puts element
    end
  elsif(data.is_a?(Hash))
    data.each do |k,v|
      puts "::#{k.to_s.upcase}::\n"
      v.each do |el|
        puts "#{el}\n"
      end
    end
  end
end

def print_info_for_species(species)
  species_found = false
  @parsers.each do |parser|
    species_data = parser.species_data
    if(species_data.include?(species))
      species_found = true
      index = species_data.index(species)    
      data = parser.csv_data[index]
      parser.data_fields.each_with_index do |field, i|
        if(data[i].nil? || data[i].empty?)
          next
        else 
          puts "#{field}: #{data[i]}"
        end       
      end
    end    
    break if species_found
  end
  puts "Dinosaur #{species} not found!!" unless species_found
end

parse_and_print_info(["carnivores", "bipeds","periods", "weight"])
#print_info_for_species("Megalosaurus")
