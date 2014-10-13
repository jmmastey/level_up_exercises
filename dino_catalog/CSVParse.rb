require 'csv'
require 'pp'
require_relative 'Dinosaur.rb'

class CSVParse
	HEADER_TAG = {
		'genus' => 'name',
		'weight_in_lbs' => 'weight',
	}

	BIPED = 'biped'
	Dinos =[]

	def parse_csv input_csv
		CSV.foreach(input_csv,
			:headers => true,
			:header_converters => [:downcase,
			 lambda { |h| HEADER_TAG[h] || h},
			  :symbol]
			 ) do |row|

			Dinos.push(Dinosaur.new(row))
		end
		Dinos
	end # parse_dinodex()

end # class CSVParse
