require_relative "dasScanner"

class DasTable
	attr_reader :headers, :table
	include DasScanner
	include DasLogic
	
	def initialize
		@headers = []
		@table = []
		setTable
	end




end

#tb = DasTable.new
