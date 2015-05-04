require 'csv'
require './dino_class1.rb'

class CsvImporter
  
    def initialize(input_files)
        @raw_dino_info = Array.new
        input_files.each { |fname| @raw_dino_info += import_csv_file(fname) }
        @raw_dino_info
    end

    def import_csv_file(filename)
         csv=Array.new
         CSV.foreach(filename, headers: true, header_converters: :symbol ) do |row|
             csv << row
         #puts row
         end
         #p csv[0][:name]
         #p csv[-1][:name]
         csv
     end

     def create_dinos()
        @dinos=Array.new
        @raw_dino_info.each_with_index do |row, i|
           # if row[:genus]!=nil                                    
           #     row[:name]=row[:genus]
           # end
            row[:name]=row[:genus] unless row[:genus].nil?
            row[:continent]="Africa" if row[:continent].nil? 

            if row[:carnivore]=="Yes"
                row[:diet]="Carnivore"
            elsif
                row[:carnivore]=="No"
                row[:diet]="Herbivore"
            end

            @dinos[i]= Dino.new(row)      
        end
        @dinos.each do |j|
         #   p j.name
         #   p j.period
         #   p j.continent
         #   p j.diet
         #   p j.weight
         #   p j.walking 
         #   p j.description
        end
    @dinos
    end

end
