require './dino'

class DinoDex

	def initialize(*files)

		@dex = Hash.new()

		if files.nil? || files.size == 0
			raise 'We have no files to initialize our Dino Dex!'
		else
			files.each do |file|
				process_file(file)
			end
		end

	end


	def process_file(file)

		File.open(file, "r") do |source|

			enum = source.each

			header = enum.next

			config = process_header(header)


			enum.each do |c|

				# split em out and remove the \n and stuffz
				items = c.split(',').map!{|i|i.gsub(/\s\z/,"")}

				# make the default nil
				# this is used in the Dino initialize
				dino_hash = Hash.new(nil)

				config.each_with_index do |key, index|

					if key == :special_diet_carnivore
						if(items[index] == "Yes")
							dino_hash[:diet] = "Carnivore"
						else
							# Leave this field nil?
							dino_hash[:diet] = nil
						end
					else
						dino_hash[key] = items[index]
					end

				end

				d = Dino.new(dino_hash)

			end

		end


	end

	def process_header header

		# split header items
		# make lowercase
		# remove whitespace
		columns = header.split(',')
		columns.map!{|h|h.gsub(/\s+/,"").downcase}
		return columns.map{|h|Dino.get_symbol_key(h)}


	end



	# Not sure what the defacto is here for access (?)
	private :process_file, :process_header


end


# Skip validation of locale
I18n.enforce_available_locales = false

dex = DinoDex.new('dinodex.csv','african_dinosaur_export.csv')
