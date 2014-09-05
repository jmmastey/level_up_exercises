require 'JSON'
require 'CSV'
require 'dinosaur'

class DinodexController
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
			@output.puts 'Enter your selection: (h for help)'
			selection = gets.chomp
			case selection[0]
			when "d"
				filterAndDetail("name=#{selection[2..-1]}")
			when "k"
				keyDisplay
			when "l"
				listDisplay
			when "f"
				filterAndDisplay(selection[2..-1])
      when "g"
        filterAndDetail(selection[2..-1])
      when "j"
        filterAndJSON(selection[2..-1])
			when "q"
				@output.puts 'Goodbye'
			when "?", "h"
				helpDisplay
			else
				@output.puts "invalid selection, try again"
			end
			@output.puts ''
		end while selection != "q"
		
	end

	def helpDisplay
		@output.puts 'd [name]          detailDisplay    show all details of the dinosaur [name],'
		@output.puts '                                   "d Abrictosaurus"'
		@output.puts 'f [key=value]|... filterAndDisplay show the names of the dinosaurs that have the matching '
		@output.puts '                                   key and value, "f walking=biped". Multiple with pipe '
		@output.puts '                                   delimiting, like "f walking=biped|diet=omnivore"'
		@output.puts 'g [key=value]|... filterAndDetail  same as "f", but shows details instead of just name'
    @output.puts 'j [key=value]|... filterAndJSON    same as "f", but shows JSON'
		@output.puts 'k                 keyDisplay       show all the dinosaur attributes for filtering'
		@output.puts 'l                 listDisplay      show all dinosaur names'
		@output.puts 'q                 quit'
		@output.puts '?, h              help'
	end
	
	def keyDisplay
		@output.puts 'Keys available: name, period, diet, weight, walking, description, continent'
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
					#TODO: change this to just a map? dinosaur.send(fieldLookup[field] +"=", value)
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

	def listDisplay(dinosaurs = @dinosaurs)
		dinosaurs.each do |dinosaur|
			@output.puts dinosaur.name			
		end
	end

  def detailDisplayByName(name)
    dinosaur = @dinosaurs.select {|dinosaur| dinosaur.name.downcase == name.downcase}[0]
    if !dinosaur.nil?
      detailDisplay(dinosaur)
    else
      @output.puts 'Dinosaur with name \'' + name + '\' not found.';
    end

  end

	#TODO: have string and object inputs?
	def detailDisplay(dinosaur)
    @output.puts dinosaur.name
    @output.puts 'Period: ' + dinosaur.period if !dinosaur.period.nil?
    @output.puts 'Diet: ' + dinosaur.diet if !dinosaur.diet.nil?
    @output.puts 'Walking: ' + dinosaur.walking if !dinosaur.walking.nil?
    @output.puts 'Description: ' + dinosaur.description if !dinosaur.description.nil?
    @output.puts 'Continent: ' + dinosaur.continent if !dinosaur.continent.nil?
  end

	def filterAndDisplay(keyValuePairs)
		listDisplay(getFilteredList(keyValuePairs))
	end
	
	def filterAndDetail(keyValuePairs)
		getFilteredList(keyValuePairs).each { |dinosaur| detailDisplay(dinosaur) }
	end

  def filterAndJSON(keyValuePairs)
    @output.puts JSON::dump(getFilteredList(keyValuePairs))
  end

	def getFilteredList(keyValuePairs)
		filteredList = Array.new(@dinosaurs) #@dinosaurs.dup
		keyValuePairs.split('|').each do |keyValuePair|
      comparison = keyValuePair[/[<>=]/]
      key, value = keyValuePair.split(/[<>=]/)

			if !Dinosaur.method_defined?(key)
				@output.puts 'Invalid dinosaur attribute \'' + key + '\' used'
				next
			end
			
			if value.nil?
				@output.puts "Empty value for '#{key}' used"
				next
			end

      if comparison == "="
        filteredList.select! {|dinosaur| dinosaur.send(key).nil? ? false : (dinosaur.send(key).downcase.include? (value.downcase) )}
      elsif comparison == "<"
        filteredList.select! {|dinosaur| dinosaur.send(key).nil? ? false : dinosaur.send(key).to_i < value.to_i}
      elsif comparison == ">"
        filteredList.select! {|dinosaur| dinosaur.send(key).nil? ? false : dinosaur.send(key).to_i > value.to_i}
      end
		end
		filteredList	
	end
end
