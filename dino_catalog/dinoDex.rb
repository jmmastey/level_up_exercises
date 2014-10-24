require 'csv'

def grabDinos(dinoarray, qText, hname)
	dinoarray.each do |ff|
		temp = ff[hname]
		if qText == "CARNIVORE" 
  		if temp != nil and (temp.upcase == qText or temp.upcase == "INSECTIVORE" or temp.upcase == "PISCIVORE")
							puts ff['name']
			end #  if temp != nil and (temp.upcase == qText or temp.ucase == "INSECTIVORE" or temp.ucase == "PISCIVORE")
		elsif hname == "weight"
			if temp != nil and qText == "BIG" and temp.to_i > 2000
							puts ff['name']
			elsif temp != nil and qText == "SMALL" and temp.to_i < 2000
							puts ff['name']
			end
		elsif qText == "PERIOD"
				puts (ff['name'] + " - " + ff['period'])
  	elsif temp != nil and temp.upcase == qText
    	puts ff['name']
		end # 	if qText == "CARNIVORE" 
	end #	dinoarray.each do |ff|
end 	

def eachDino(dinos, userReq)
	dinos.each do |dd|
		dinotemp = dd['name']
		if dinotemp.upcase == userReq.upcase
					dd.each.sort_by {|k, v| print k.upcase, ":    ", v, "\n"}
		elsif userReq.upcase == "ALL" 
					dd.each.sort_by {|k, v| print k.upcase, ":    ", v, "\n"}
					print("************************************************\n")
		end
	end
end

allDinos = Array.new
array_csv_files = ['dinodex.csv','african_dinosaur_export.csv']
#puts array_csv_files
array_csv_files.each do |file|
	csv = CSV.read(file, :headers => true, :header_converters => [:downcase])
	csv.by_row!
	
	csv.each do |row|
	 dino_temp = row.to_hash
	 if dino_temp['genus'] != nil 
	  	dino_temp['name'] = dino_temp.delete('genus')
		  dino_temp['diet'] = (dino_temp.delete('carnivore') == 'Yes')?'Carnivore':'Not Carnivore'
	 elsif 
		  dino_temp['weight'] = dino_temp.delete('weight_in_lbs')
	 end
	 allDinos << dino_temp
	end
end
 
print("Enter a single choice or comma separated choices, please select from given (Biped, Quadruped, Carnivore, period, big, small, info by name) : ")
userq = gets.chomp

userinput = userq.split(",")
userinput.each do |val|
	uinput = val.strip
	case uinput.upcase
		when "BIPED"
			puts "Dinosaurs that were bipeds are: \n"
			grabDinos allDinos, uinput.upcase, "walking"
		when "QUADRUPED"
			puts "Dinosaurs that were quadrupeds are: \n"
			grabDinos allDinos, uinput.upcase, "walking"
		when "CARNIVORE"
		  puts "Dinosaurs that were carnivores are: \n"
			grabDinos allDinos, uinput.upcase, "diet"
		when "PERIOD"
			puts "List of all Dinosaurs based on the period of existence are: \n"
			grabDinos allDinos, uinput.upcase, "period"
		when "BIG"
			puts "Dinosaurs that were big (over 2 tons) are :\n"
			grabDinos allDinos, uinput.upcase, "weight"
		when "SMALL"
			puts "Dinosaurs that were small (less than 2 tons) are :\n"
			grabDinos allDinos, uinput.upcase, "weight"
		when "INFO BY NAME"
			print("Enter the name of the dinosaur to print the facts or type all to get information on all Dinosaurs: \n")
			userDino = gets.chomp
			eachDino allDinos, userDino
		else
			puts "No selection made"
	end
end

