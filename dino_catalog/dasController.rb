

require_relative "dasLogic"
require_relative "dasView"
require_relative "dasTable"

class DasController
	def initialize
		@table = DasTable.new
		@view = DasView.new
		@logic = DasLogic.new
	end

	def run
		@view.greetingDisplay
		command = ["help"]
		while true		

			case command[0]
			when "-e", "exit"
				break
			when "-h", "help"
				@view.optionsDisplay
			when "-l", "list"
				puts "listing stuff"
			when "-c", "categories"
				puts "catting stuff"
			when "-s", "search"
				puts "searching stuff"
			end

			print "Dino Request: "
			command = gets.chomp.split(" ")
		end
	end




end

defacto = DasController.new
defacto.run