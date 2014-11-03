require 'csv'
require 'pry'

class Dinodex
  attr_accessor :question_text, :header_name, :user_req
  WEIGHT_CATEGORY = 4000

  def initialize(array_csv_files)
    @alldinos = []
    @question_text = question_text
    @header_name = header_name
    @user_req = user_req
    array_csv_files.each do |file|
      csv = CSV.read(file, :headers => true, :header_converters => [:downcase])
      csv.by_row!
      csv.each do |row|
        dino_temp = row.to_hash
        if dino_temp['genus'] != nil
          dino_temp['name'] = dino_temp.delete('genus')
          dino_temp['diet'] = (dino_temp.delete('carnivore') == 'Yes') ? 'Carnivore' : 'Not Carnivore'
        elsif  dino_temp['weight'] = dino_temp.delete('weight_in_lbs')
        end
        @alldinos << dino_temp
      end
    end
  end

  def grab_dinos(question_text, header_name)
    matching_dinos = []
    @alldinos.each do |each_item|
      header_value = each_item[header_name]
      if question_text == 'CARNIVORE'
        matching_dinos << each_item['name'] if !header_value.nil? && dino_diet?(header_value)
      elsif question_text == 'BIG'
        matching_dinos << each_item['name'] if !header_value.nil? && header_value.to_i > WEIGHT_CATEGORY
      elsif question_text == 'SMALL'
        matching_dinos << each_item['name'] if !header_value.nil? && header_value.to_i < WEIGHT_CATEGORY
      elsif header_name == 'period' && (each_item['period'].downcase.include? question_text.downcase)
        matching_dinos << each_item['name']
      elsif header_value.casecmp(question_text) == 0 #Biped or Quadruped selection 
        matching_dinos << each_item['name']
      elsif question_text == 'INFO BY NAME'
        each_dino header_name
        break
      end 
    end
    print_dinos matching_dinos 
  end 

  def print_dinos(dino_output)
    dino_output.each do |dino_out|
      puts dino_out
    end
  end	

  def dino_diet?(header_val)
    (header_val.casecmp('carnivore') == 0) || (header_val.casecmp('INSECTIVORE') == 0) || (header_val.casecmp('PISCIVORE') == 0)
  end

  def each_dino(user_req)
    @alldinos.each do |dino_d|
      dinotemp = dino_d['name']
      if (dinotemp.casecmp(user_req) == 0)
        print("************************************************\n")
        dino_d.each.sort_by { |k, v| print k.upcase, ":\t", v, "\n" }
        print("************************************************\n")
      elsif user_req.upcase == 'ALL' 
        dino_d.each.sort_by { |k, v| print k.upcase, ":\t", v, "\n" }
        print("************************************************\n")
      end
    end
  end
end

array_csv = ['dinodex.csv', 'african_dinosaur_export.csv']
my_dino  = Dinodex.new (array_csv)

print 'Enter a choice or comma separated choices, please select from (Biped, Quadruped, Carnivore, period, big, small, info by name) : '
userq = gets.chomp

userinput = userq.split(',')
userinput.each do |val|
  uinput = val.strip
  question_text = uinput.upcase
  case question_text
  when 'BIPED', 'QUADRUPED'
    puts "Dinosaurs that were #{question_text} are: \n"
    my_dino.grab_dinos question_text, 'walking'
  when 'CARNIVORE'
    puts "Dinosaurs that were carnivores are: \n"
    my_dino.grab_dinos question_text, 'diet'
  when 'PERIOD'
    print "Enter the period from the choice of - (Cretaceous, Permian, Jurassic, Oxfordian, Triassic, Albian): \n"
    user_period = gets.chomp
    puts "List of all Dinosaurs for the period of #{user_period} are: \n"
    my_dino.grab_dinos user_period, 'period'
  when 'BIG', 'SMALL'
    puts "Dinosaurs that were #{question_text} are :\n"
    my_dino.grab_dinos question_text, 'weight'
  when 'INFO BY NAME'
    print "Enter the name of the dinosaur to print the facts or type all to get information on all Dinosaurs: \n"
    user_dino = gets.chomp
    my_dino.grab_dinos question_text, user_dino
  else
    puts 'No selection made'
  end
end
