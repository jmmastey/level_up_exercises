require 'hirb'
require 'json'

class DinoDexSearch

	def initialize(dex)
		@dex = dex
	end

	def where(key, value)

		@dex.keep_if do |h|
			h.instance_variable_get("@#{key}") == value
		end

		self
	end


	def where_in(key, *values)

		@dex.keep_if do |h|

			keep = false

			values.each do |value|
				if h.instance_variable_get("@#{key}") == value
					keep = true
				end
			end

			keep
		end

		self
	end



	def more_than(key, value)
		@dex.keep_if do |h|
			h.instance_variable_get("@#{key}").to_i > value
		end

		self
	end

	def do_sort
		@dex.sort! do |a,b|
			a.name.downcase <=> b.name.downcase
		end
	end


	def print

		do_sort

		display_array = []


		@dex.each do |dino|
			display_array <<
				[
					dino.name, dino.period, dino.continent,
					dino.diet, dino.weight, dino.walking,
					dino.description
				]
		end


		puts Hirb::Helpers::AutoTable.render(display_array,
			:headers =>
				%w(NAME PERIOD CONTINENT DIET
					WEIGHT WALKING DESCRIPTION))


	end

	def export_json
		do_sort
		json_array = []

		@dex.each do |dino|
			json_array << dino.to_json_hash
		end

		puts JSON.generate(json_array)

	end

end
