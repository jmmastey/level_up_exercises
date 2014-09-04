require 'CSV'
require 'dinosaur'

class Dinodex
	def initialize(output)
		@output = output
		@dinosaurs = []
	end
	
	def dinosaurs
		@dinosaurs ||= []
	end
	
	def csvFiles
		@csvFiles ||= []
	end
	
	def start(directory)
		findCSVfiles(directory)
		csvFiles.each do |file|
			loadCSVfile(directory + '\\' + file)
		end
	end

	def interactionLoop
		@output.puts 'Welcome to Dinodex'
		
		begin
			@output.puts 'Enter your selection:'
			@output.puts '(q=quit, l=listDisplay d [name]=detailDisplay)'
			selection = gets.chomp
			case selection[0]
			when "d"
				detailDisplay(selection[2..-1])
			when "l"
				listDisplay
			when "q"
				@output.puts 'Goodbye'
			else
				@output.puts "invalid selection, try again"
			end
			@output.puts ''
		end while selection != "q"
		
	end
	
	def findCSVfiles(directory)
		@output.puts 'Finding CSV files in ' + directory
		Dir.entries(directory).select{|f| File.extname(f) == '.csv'}.each do |f|
			@output.puts 'Found ' + File.basename(f)
			csvFiles.push f
		end
	end
	
	def loadCSVfile(file)
		newDinosaurs = []
		if !File.exists?(file)
			@output.puts 'File ' + file + ' not found';
			return
		end

		table = CSV.read(file, {headers: true})
		table.each do |row|
			dinosaur = Dinosaur.new
			#TODO: change this to just a map?
			row.fields.each_with_index do |field, index|
				if !field.nil?
					if ["genus","name"].include? table.headers[index].downcase
						dinosaur.name = field
					elsif ["period"].include? table.headers[index].downcase
						dinosaur.period = field
					elsif ["diet"].include? table.headers[index].downcase
						dinosaur.diet = field
					elsif ["carnivore"].include? table.headers[index].downcase
						dinosaur.diet = field.downcase == "yes" ? "Carnivore" : "Omnivore"
					elsif ["weight_in_lbs", "weight"].include? table.headers[index].downcase
						dinosaur.weight = field
					elsif ["walking"].include? table.headers[index].downcase
						dinosaur.walking = field
					elsif ["description"].include? table.headers[index].downcase
						dinosaur.description = field
					elsif ["continent"].include? table.headers[index].downcase
						dinosaur.continent = field
					end
				end
			end
			@dinosaurs.push dinosaur
		end
		
		@output.puts 'Found ' + table.length.to_s + ' dinosaurs in ' + file
	end

	def listDisplay
		@dinosaurs.each do |dinosaur|
			@output.puts dinosaur.name			
		end
	end

	def detailDisplay(name)
		dinosaur = @dinosaurs.select {|dinosaur| dinosaur.name.downcase == name.downcase}[0]
		if !dinosaur.nil?
			@output.puts dinosaur.name
			@output.puts 'Period: ' + dinosaur.period if !dinosaur.period.nil?
			@output.puts 'Diet: ' + dinosaur.diet if !dinosaur.diet.nil?
			@output.puts 'Walking: ' + dinosaur.walking if !dinosaur.walking.nil?
			@output.puts 'Description: ' + dinosaur.description if !dinosaur.description.nil?
			@output.puts 'Continent: ' + dinosaur.continent if !dinosaur.continent.nil?
		else
			@output.puts 'Dinosaur with name \'' + name + '\' not found.';
		end
	end
	
end
