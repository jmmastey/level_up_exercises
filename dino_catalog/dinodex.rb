require 'csv'
require 'pry'
require 'json'
require_relative 'dinosaur.rb'
require_relative 'dinolibrary.rb'

# Merge dino files and extract based on user input
class Dinodex
  attr_accessor :q_text, :hdr_name, :user_req
  WGHT_LIMIT = 4000

  def initialize(file_array)
    @alldinos = []
    @alldinos = DinoLibrary.new(file_array)
  end

  def print_dinos(hash = {})
    dino_output = @alldinos.grab_dinos(hash)
    dino_output.each do |dino_out|
      print("************************************************\n")
      dino_out.to_h.each { |k, v| print k.upcase, ":\t", v, "\n" unless v.nil? }
      print("************************************************\n")
    end
    print("#################################################\n")
  end

  def convert_json
    json_file = File.new('dinos.json', 'w')
    dino_hash = @alldinos.all_dinosaurs
    json_file.puts dino_hash.to_json
    json_file.close
  end
end

array_csv = ['dinodex.csv', 'african_dinosaur_export.csv']
my_dino  = Dinodex.new(array_csv)
print 'Enter one or more comma separated choices (Biped, Quadruped, Carnivore,
       period, big, small, info by name) or type json to create json file:'
userq = gets.chomp
userinput = userq.split(',')
userinput.each do |val|
  question_text = val.strip.upcase
  case question_text
  when 'BIPED', 'QUADRUPED'
    puts "DINOSAURS THAT WERE #{question_text} ARE: \n"
    my_dino.print_dinos('walking' => question_text)
  when 'CARNIVORE'
    puts "DINOSAURS THAT WERE CARNIVORES ARE: \n"
    my_dino.print_dinos('diet' => question_text)
  when 'PERIOD'
    print "Enter the period from the choice of - (Cretaceous, Permian,
           Jurassic, Oxfordian, Triassic, Albian): \n"
    user_period = gets.chomp.upcase
    puts "LIST OF ALL DINOSAURS FOR THE PERIOD OF #{user_period} ARE: \n"
    my_dino.print_dinos('period' =>  user_period)
  when 'BIG', 'SMALL'
    puts "DINOSAURS THAT WERE #{question_text} ARE:\n"
    my_dino.print_dinos('size' => question_text)
  when 'INFO BY NAME'
    print "Enter the name of the dinosaur to print the facts: \n"
    user_dino = gets.chomp.upcase
    my_dino.print_dinos('name' => user_dino)
  when 'JSON'
    my_dino.convert_json
  else
    puts 'No selection made'
  end
end
