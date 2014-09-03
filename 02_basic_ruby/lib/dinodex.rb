require 'CSV'
require 'dinosaur'

class Dinodex
	def initialize(output)
		@output = output
	end
	
	def dinosaurs
		@dinosaurs ||= []
	end
	
	def start
		@output.puts 'Welcome to Dinodex'
		@output.puts 'Enter your selection:'
	end
	
	def findCSVfiles(directory)
		@output.puts 'Finding CSV files in ' + directory
		Dir.entries(directory).select{|f| File.extname(f) == '.csv'}.each do |f|
			@output.puts 'Found ' + File.basename(f)
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
					end
				end
			end
			newDinosaurs.push dinosaur
		end
		
		@output.puts 'Found ' + newDinosaurs.length.to_s + ' dinosaurs in ' + file
		dinosaurs.push newDinosaurs
	end
end
