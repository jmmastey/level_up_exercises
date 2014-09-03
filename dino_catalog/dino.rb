require 'csv'

class Dino
	attr_accessor :name, :period, :continent, :diet, :weight_in_lbs, :walking, :description

	def initialize(row)
		row.each do |key, val| 
			val = val.downcase if val.is_a? String
			instance_variable_set("@#{key}",val) 
		end
	end

	def weight_in_lbs
		@weight_in_lbs.to_i
	end

	def is_biped?
		@walking.downcase == "biped"
	end

	def eats_meat?
		["carnivore", "insectivore", "piscivore"].include? @diet.downcase 
	end

	def from_period?(period_name)
		@period.downcase.include? period_name.downcase
	end

	def to_hash
    hash = {}
    instance_variables.each {|var| hash[var.to_s.delete("@")] = instance_variable_get(var) }
    hash
	end

	def to_s
		to_hash.map{ |key, val| "#{key.capitalize}: #{val}" }.join(" --- ")
	end
end

