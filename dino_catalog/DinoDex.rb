require "CSV"
require "json"

class Dinosaur
	attr_accessor :name, :period, :continent, :diet, :weight, :walking, :description
  def initialize
	end
	
	def to_hash
		#Hash[*instance_variables.map { |v| [v.to_sym, instance_variable_get(v)] }.flatten]
		hash_obj = {}
		hash_obj["name"] = name
		hash_obj["period"] = period
		hash_obj["continent"] = continent
		hash_obj["diet"] = diet
		hash_obj["weight"] = weight
		hash_obj["walking"] = walking
		hash_obj["description"] = description
		return hash_obj
	end
end

class DinoDex
	@dic
	def initialize(list_of_csv)
		@dic = []
		list_of_csv.each do |f|
			CSV.foreach(f, { :headers=>true, :header_converters=>[:downcase] }) do |row|
				hash_obj = row.to_hash
				dino = Dinosaur.new
				dino.name = row.headers.include?("name")? hash_obj["name"] : hash_obj["genus"]
				dino.period = hash_obj["period"] 
				dino.continent = hash_obj["continent"]
				dino.diet = row.headers.include?("diet")? hash_obj["diet"] : hash_obj["carnivore"]
				dino.weight = row.headers.include?("weight_in_lbs")? hash_obj["weight_in_lbs"] : hash_obj["weight"]
				dino.walking = hash_obj["walking"]
				dino.description = row.headers.include?("description")? hash_obj["description"] : nil
				@dic << dino
			end
		end
	end


	def filter_by_name(name)
	  puts "\n=== Filter by name = #{name} ==="
		name = name.downcase
		putty_print @dic.select { |d| d.name.downcase.include?(name) && !d.period.nil? && !d.continent.nil? && !d.diet.nil? && !d.weight.nil? && !d.walking.nil? && !d.description.nil? }
	end 
	
	def filter_by_period(keyword)
		puts "\n=== Filter by period = #{keyword} ==="
		keyword = keyword.downcase
		putty_print @dic.select { |d| d.period.downcase.include? keyword }
  end
	
	def filter_by_diet(keyword)
		puts "\n=== Filter by diet = #{keyword} ==="
		if keyword.downcase == "carnivore"
			putty_print @dic.select { |d| !d.diet.nil? && ["carnivore","insectivore","piscivore","yes"].include?(d.diet.downcase) }
		else
			putty_print @dic.select { |d| !d.diet.nil? && !["carnivore","insectivore","piscivore","yes"].include?(d.diet.downcase) }
		end
	end
	 
	def filter_by_continent(keyword)
		puts "\n=== Filter by continent = #{keyword} ==="
	  keyword = keyword.downcase
		putty_print @dic.select { |d| !d.continent.nil? && d.continent.downcase.include?(keyword) }
	end
 
  def filter_by_walking(keyword)
		puts "\n=== Filter by walking = #{keyword} ==="
		keyword = keyword.downcase
		putty_print @dic.select { |d| !d.walking.nil? && d.walking.casecmp(keyword) }
	end
	
	def filter_by_size(size)
		puts "\n=== Filter by size = #{size} ==="
		if size.downcase == "big"
			putty_print @dic.select { |d| d.weight != nil && d.weight.to_i > 4000 }
		end

		if size.downcase == "small"
			putty_print @dic.select { |d| d.weight != nil && d.weight.to_i <= 4000 }
		end 
	end

	def filter_by_hash(hash_obj)
		temp_hash = @dic;
		hash_obj.each do |k,v|
			k = k.downcase.strip
			v = v.downcase.strip
			case k
			when "name"	
				temp_hash = temp_hash.select { |d| d.name.downcase.include? v }
			when "period"
				temp_hash = temp_hash.select { |d| !d.continent.nil? && d.period.downcase.include?(v) } 
			when "continent"
				temp_hash = temp_hash.select { |d| !d.continent.nil? &&  d.continent.downcase.include?(v) }
			when "diet"
				if v == "carnivore"
					temp_hash = temp_hash.select { |d| !d.diet.nil? && ["carnivore","insectivore","piscivore","yes"].include?(d.diet.downcase) }
				else
					temp_hash = temp_hash.select { |d| !d.diet.nil? && !["carnivore","insectivore","piscivore","yes"].include?(d.diet.downcase) }
				end
			when "size"
				if v == "big"
					temp_hash = temp_hash.select { |d| d.weight != nil && d.weight.to_i > 4000 }
				end

				if v == "small"
					temp_hash = temp_hash.select { |d| d.weight != nil && d.weight.to_i <= 4000 }
				end
				 	
			when "walking"
				temp_hash = temp_hash.select { |d| !d.walking.nil? && d.walking.downcase.include?(v) }
			end
		end
		
			putty_print temp_hash
	end

	def together
		putty_print @dic.select { |d| d.walking == "Biped" && (["Carnivore","Insectivore","Piscivore","Yes"].include? d.diet) && d.period == "Cretaceous" && d.weight.to_i > 4000 }
	end

	def to_json
		temp = []
		@dic.each do |dino|
			temp << dino.to_hash
		end
		File.open("DinoDex.json","w") do |f|
			f.write(temp.to_json)
		end
	end

  def putty_print(list)
   	printf "%-20s %-20s %-20s %-20s %-20s %-20s %-20s \n", "Name", "Peroid", "Continet", "Diet", "Weight", "Walking", "Description"	
		list.each do | dino|
			printf "%-20s %-20s %-20s %-20s %-20s %-20s %-20s \n", dino.name, dino.period, dino.continent, dino.diet, dino.weight, dino.walking, dino.description
		end
	end
end

dex = DinoDex.new(["dinodex.csv","african_dinosaur_export.csv"])
dex.filter_by_walking("Biped")
dex.filter_by_diet("carnivore")
dex.filter_by_period("Cretaceous")
dex.filter_by_size("small")
puts "\n  Filter by : name, period, continet, diet, size, walking. ex. name:baryonyx \n"
puts "  together : chain all filters ex. together \n"
puts "  custom_filter : custom filter with given hash. Ex, custom_filter:{'diet'=>'carnivore', 'size'=>'big'}\n"

puts "  to_json : export to json. ex. to_json\n"
puts "Please enter : "
input = gets.chomp
if input == ""
	puts "You didn't enter anything. bye ....."
	exit
end
input = input.strip
if input == "together"
	 dex.together
	 exit
elsif input == "to_json"
	dex.to_json
	exit
end

tokens = input.split(':')
if tokens.size != 2
	puts "Invalid input bye... "
	exit
end

case tokens[0].strip
when "name"	
	dex.filter_by_name(tokens[1].strip)
when "period"
	dex.filter_by_period(tokens[1].strip)
when "continent"
	dex.filter_by_continent(tokens[1].strip)
when "diet"
	dex.filter_by_diet(tokens[1].strip)
when "size"
	dex.filter_by_size(tokens[1].strip)
when "walking"
	dex.filter_by_walking(tokens[1].strip)
when "custom_filter"
	hash_obj = eval tokens[1].strip
	dex.filter_by_hash(hash_obj)
end
