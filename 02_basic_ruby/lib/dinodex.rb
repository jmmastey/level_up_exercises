require 'CSV'
require 'dinosaur'

class Dinodex
	def initialize(output)
		@output = output
	end
	
	def dinosaurs
		@dinosaurs ||= []
	end
	
	def csvFiles
		@csvFiles ||= []
	end
	
	def start(directory)
		@output.puts 'Welcome to Dinodex'
		findCSVfiles(directory)
		csvFiles.each do |file|
			loadCSVfile(directory + '\\' + file)
		end
		interactionLoop
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
			newDinosaurs.push dinosaur
		end
		
		@output.puts 'Found ' + newDinosaurs.length.to_s + ' dinosaurs in ' + file
		dinosaurs.push newDinosaurs
	end

	def interactionLoop

		@output.puts 'Enter your selection:'
		
		begin
			selection = gets.chomp
		
		end while selection != "q"
		
		@output.puts 'Goodbye'
	end
end
