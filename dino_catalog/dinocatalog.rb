class Dinobase
	@dinosaurs
	@DEBUG

	def dinosaurs
		@dinosaurs
	end

	def initialize(args = {})
	  @dinosaurs = Array.new
	  @DEBUG = false
	end

	def open_and_read_file(file_path)
		file = File.open(file_path, "r")
		data = file.read
		file.close
		return data
	end

	def new_entry_for_dinodex_row(row)
	  cells = row.split(',')

	  new_entry = Hash.new
	  new_entry['name'] = cells[0]
	  new_entry['period'] = cells[1]
	  new_entry['continent'] = cells[2]
	  new_entry['diet'] = cells[3]
	  new_entry['weight'] = /\A[-+]?\d+\z/ === cells[4] ? cells[4] : 'N/A'
	  new_entry['walking'] = cells[5]
	  new_entry['description'] = cells[6]

	  return new_entry
	end

	def parse_dinodex
	  csv_path = './dinodex.csv'
	  csv_content = open_and_read_file(csv_path)  
	  line_count = 0
	  skipped_first_line = false
	  csv_content.each_line do |row| 
			#skip the header.
		if skipped_first_line == false 
			skipped_first_line = true
			next
		end
	  	new_entry = new_entry_for_dinodex_row(row)
  
	  	@dinosaurs.push(new_entry)
	  	line_count += 1
	  end
	  if @DEBUG 
	    print "Just loaded "+line_count.to_s+" Dinosaurs from dinodex\n"
	  end
	end

	def new_entry_for_african_dinos_row(row)
		cells = row.split(',')

		new_entry = Hash.new
		new_entry['name'] = cells[0]
		new_entry['period'] = cells[1]
		new_entry['continent'] = 'N/A'
		new_entry['diet'] = cells[2] == 'Yes' ? 'Carnivore' : 'Herbivore'
		new_entry['weight'] = /\A[-+]?\d+\z/ === cells[3] ? cells[3] : 'N/A'
		new_entry['walking'] = cells[4]
		new_entry['description'] = 'Not a lot is known about '+cells[0]+' at this point.'

		return new_entry
	end

	def parse_african_dinos
		csv_path = './african_dinosaur_export.csv'
		csv_content = open_and_read_file(csv_path)

		line_count = 0
		skipped_first_line = false
		csv_content.each_line do |row| 
			#skip the header.
			if skipped_first_line == false 
				skipped_first_line = true
				next
			end
			new_entry = new_entry_for_african_dinos_row(row)
	
			@dinosaurs.push(new_entry)
			line_count += 1
		end
		if @DEBUG 
		  print "Just loaded "+line_count.to_s+" Dinosaurs from african dinosaurs\n"
		end
	end

end

class Dinocalls

	def filter_bipeds(dinosaurs)
		newDinoList = Array.new

		dinosaurs.each do |dino| 
			dinoBipedStatus = dino['walking']

			if dinoBipedStatus == 'Biped'
				newDinoList.push(dino)
			end
		end

		return newDinoList
	end

	def filter_carnivors(dinosaurs)
		newDinoList = Array.new

		dinosaurs.each do |dino| 
			dinoDietStatus = dino['diet']

			if dinoDietStatus != 'Herbivore'
				newDinoList.push(dino)
			end
		end

		return newDinoList
	end

	def filter_small(dinosaurs)
		newDinoList = Array.new

		dinosaurs.each do |dino| 
			dinoSizeStatus = dino['weight']
			if dinoSizeStatus == 'N/A'
				next
			end

			dinoSizeInt = dinoSizeStatus.to_i

			if dinoSizeInt <= 2000 
				newDinoList.push(dino)
			end
		end

		return newDinoList
	end

	def filter_big(dinosaurs)
		newDinoList = Array.new

		dinosaurs.each do |dino| 
			dinoSizeStatus = dino['weight']
			if dinoSizeStatus == 'N/A'
				next
			end

			dinoSizeInt = dinoSizeStatus.to_i

			if dinoSizeInt >= 2000
				newDinoList.push(dino)
			end
		end

		return newDinoList
	end

	def filter_period(dinosaurs, period_string)
		newDinoList = Array.new

		dinosaurs.each do |dino| 
		dinoPeriod = dino['period']

			if dinoPeriod.downcase.include? period_string.downcase
				newDinoList.push(dino)
			end
		end

		return newDinoList
	end

	def filter_search(dinosaurs, search_string)
		newDinoList = Array.new

		dinosaurs.each do |dino| 
			dinoName = dino['period']
			dinoDescription = dino['description']
			dinoPeriod = dino['period']
			dinoDiet = dino['diet']
			dinoContinent = dino['continent']
			dinoWalking = dino['walking']
			dinoWeight = dino['weight']

			if dinoName.downcase.include?(search_string.downcase) ||
				dinoDescription.downcase.include?(search_string.downcase) ||
				dinoPeriod.downcase.include?(search_string.downcase) ||
				dinoDiet.downcase.include?(search_string.downcase) ||
				dinoContinent.downcase.include?(search_string.downcase) ||
				dinoWalking.downcase.include?(search_string.downcase) ||
				dinoWeight.downcase.include?(search_string.downcase)

				newDinoList.push(dino)
			end
		end


		return newDinoList
	end

	def text_export(dinosaurs)
	  dinosaurs.each do |dino|
	    print "Name: "+dino['name']+"\n"
	    print "Period: "+dino['period']+"\n"
	    print "Continent: "+dino['continent']+"\n"
	    print "Diet: "+dino['diet']+"\n"
	    print "Weight: "+dino['weight']+"\n"
	    print "Walking: "+dino['walking']+"\n"
	    print "Description: "+dino['description']+"\n"
	    print "---\n"
	  end
	end

	def json_export(dinosaurs)
	  isFirstLine = true
	  print "["
	  dinosaurs.each do |dino|
	  	if !isFirstLine 
	  		print ","
	  		isFirstLine = false
	  	end
	  	print "{"
	    print "\"name\":"+"\""+dino['name']+"\","
	    print "\"period\":"+"\""+dino['period']+"\","
	    print "\"continent\":"+"\""+dino['continent']+"\","
	    print "\"diet\":"+"\""+dino['diet']+"\","
	    print "\"weight\":"+"\""+dino['weight']+"\","
	    print "\"walking\":"+"\""+dino['walking']+"\","
	    print "\"description\":"+"\""+dino['description']+"\""
	    print "}"
	  end
	  print "]"
	end

	def arg_does_not_exist(args)

		listOfValidArg = ["-b", "-c", "--period", "-s", "-B", "--search", "--help", "--json"]

		args.each do |arg|
			if arg.start_with?("-") && !listOfValidArg.include?(arg)
				print "*** Invalid Option "+arg+" ***\n"
				return true
			end
		end

		return false
	end

	def display_usage
		print "ruby dinocatalog.rb <options> \n"
		print "Options are: \n"

		print "-b 				Sort to show only bipeds dinosaurs\n"
		print "-c 				Sort to show only carnivores dinosaurs\n"
		print "--period period 	 	Sort to show dinosaurs which lived during period\n"
		print "-s 				Sort to only show small dinosaurs\n"
		print "-B 				Sort to only show big dinosaurs\n"
		print "--search pattern		Search for pattern in the database\n"
		print "--help				Shows this usage/help message\n"
		print "--json 				Export results in JSON\n"
	end

	def main(args)
	  # load data from csv
	  dinodatabase = Dinobase.new
	
	  dinodatabase.parse_dinodex
	  dinodatabase.parse_african_dinos

	  finalDinosaursList = Array.new(dinodatabase.dinosaurs)

	  if args.include?("--help") || arg_does_not_exist(args)
	  	display_usage
	  	return
	  end

	  if args.include? "-b" 
	  	finalDinosaursList = filter_bipeds(finalDinosaursList)
	  end

	  if args.include? "-c"
	  	finalDinosaursList = filter_carnivors(finalDinosaursList)
	  end

	  if args.include? "-s"
	  	finalDinosaursList = filter_small(finalDinosaursList)
	  elsif args.include? "-B"
	  	finalDinosaursList = filter_big(finalDinosaursList)	
	  end 

	  if args.include? "--period"
	  	indexOfPeriodArg = args.index("--period")
	  	periodParam = args[indexOfPeriodArg+1]

	  	finalDinosaursList = filter_period(finalDinosaursList, periodParam)
	  end

	  if args.include? "--search"
	  	indexOfSearchArg = args.index("--search")
	  	searchParam = args[indexOfSearchArg+1]

	  	finalDinosaursList = filter_search(finalDinosaursList, searchParam)
	  end

	  #finally we export our work
	  if args.include? "--json"
	  	json_export(finalDinosaursList)
	  else
		text_export(finalDinosaursList)
	  end
	end
end



# creating a new dinocall and passing args
dinocall = Dinocalls.new
dinocall.main(ARGV)


