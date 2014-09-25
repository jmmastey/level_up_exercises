require 'csv'
require 'table_print'
class Dinodex

attr_accessor :name
attr_reader   :dinosaurs

REPLACEMENT = {
"Genus"     => "NAME",
"Carnivore" => "DIET", 
"Weight"    =>"WEIGHT_IN_LBS",
"Period"    => "PERIOD",
"Walking"   => "WALKING"
}

def initialize#(name)
#@name = name
@dinosaurs = []
create_dinosaurs  
create_afro_dinosaurs
end

def create_dinosaurs
csv_text = File.read("dinodex.csv")
csv = CSV.parse(csv_text, :headers => true)
csv.map do |row|
@dinosaurs << Dinosaur.new(row)
end
end

def create_afro_dinosaurs
csv_text = File.read("african_dinosaur_export.csv")
csv = CSV.parse(csv_text, :headers => true, :skip_blanks => true, header_converters: lambda {|header| convert_headers(header)})
csv.map do |row|
@dinosaurs << Dinosaur.new(row)
end
end

def convert_headers(header)
REPLACEMENT[header] || header 
end

def user_selection
print "\n\nPlease make a selection:\n"
selection = gets.chomp.downcase.strip
end


def display_menu
puts "\t\t\tWelcome to the Dinodex"
puts "\nDinosaurs can be filtered by: <<<< NAME,PERIOD,CONTINENT,DIET,WEIGHT_IN_LBS,WALKING,DESCRIPTION >>> \n\n"
puts "\t************ Menu Options****************"
puts "\tSelect \"All\" to find all dinosaurs"
puts "\tSelect \"Bipeds\" for bipedal dinosaurs."
puts "\tSelect \"Carnivores\" for carniverous dinosaurs."
puts "\tSelect \"Grande\" for dinosaurs weighing 2000 lbs or more."
puts "\tSelect \"Petite\" for dinosaurs under 2000 lbs."
puts "\tSelect \"Lookup\" to find a dinosaur."
puts "\tType exit to close the dinodex"
end

ACTION_MAP = {
"all"        => "display_all",
"bipeds"     => ["dino_display", "WALKING", "Biped"],
"carnivores" => ["dino_display", "DIET", "Carnivore" ],
"grande"     => ["dino_display", "WEIGHT_IN_LBS", 2000, ">"],
"petite"     => ["dino_display","WEIGHT_IN_LBS", 2000, "<"]
}

def express_confusion
puts "I don't understand that selection"
end

def process_selection(selection)
if selection.match (/lookup/)
name = selection.split()[1]
display_name(name) 
else
action = ACTION_MAP.fetch(selection, "express_confusion")
if action.is_a?Array
send(action[0], action[1], action[2], action[3])
else
send(action)
end
end
end

# def process_selection(selection)  
#   if selection == "all"
#      display_all
#   elsif selection == "bipeds"
#     dino_display("WALKING", "Biped")
#   elsif selection == "carnivores"
#     dino_display("DIET", "Carnivore")
#     dino_display("DIET", "Yes")
#   elsif selection == "grande"  
#     dino_display("WEIGHT_IN_LBS", 2000, ">")
#   elsif selection == "petite"
#     dino_display("WEIGHT_IN_LBS", 2000, "<")
#   elsif selection == selection 
#     dino_display("NAME", "selection")                                   
#   else
#      puts "I don't understand that command, please make a selection from the menu"
#   end
# end  

def display_all
dinosaurs.each do |dino|
puts dino
end
end

def dino_display(key,value,comparator=nil)
dinosaurs.each do |dino|
puts dino if dino.compare(key, value, comparator)      
end
end

def display_name(name)
@dinosaurs.each do |dino|
puts dino if dino.name.downcase == name.downcase
end  
end
end

class Dinosaur
attr_reader :row

def initialize(row)
@row = row
end

def compare(key,value, comparator=nil)
if comparator == "<"
row[key].to_i < value.to_i
elsif comparator == ">"
row[key].to_i > value.to_i
else
row[key] == value
end    
end

def name
row["NAME"] 
end

def to_s 
row.inject("")do |memo, (key,value)|
next memo if value.nil?         
memo + "#{key}: #{value} ".ljust(35)
end 
end
end    

dinodex = Dinodex.new
while true
dinodex.display_menu 
selection = dinodex.user_selection
dinodex.process_selection(selection)
end



   #dinodexfossils

    # def display_bipeds
    #  dinosaurs.each do |dino|
    #   puts dino if dino.name
    # end
    # end

    # def display_bipeds
    #  dinosaurs.each do |dino|
    #   puts dino if dino.biped?
    #  end
    # end

    # def display_carnivores
    #  dinosaurs.each do |dino|
    #   puts dino if dino.carnivore
    #  end
    # end

    # def display_bigdino
    #  dinosaurs.each do |dino|
    #   puts dino if dino.big_dino
    #  end
    # end

    # def display_smalldino
    #  dinosaurs.each do |dino|
    #   puts dino if dino.little_dino 
    #  end
    # end


    #dinosaurs fossils -> compressed to key method
    
    # def biped?
    #    row["WALKING"] == "Biped"           
    # end

    # def dino_diet? (diet_type)
    #      row["DIET"] == diet_type
    # end

    # def big_dino
    #     row["WEIGHT_IN_LBS"].to_i > 2000
    # end

    # def little_dino
    #     row["WEIGHT_IN_LBS"].to_i  < 2000
    # end

    # def carnivore
    #     row["DIET"] == "Carnivore"  || row["Carnivore"] == "Yes" 
    # end
    