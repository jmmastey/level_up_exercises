

require_relative "dasLogic"
require_relative "dasView"
require_relative "dasTable"

class DasController
	def initialize
		@table = DasTable.new
		@view = DasView.new
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
				@view.dinoFullDisplay(@table.table)
			when "-c", "categories"
				@view.headerDisplay(@table.headers)

			when "-s", "search"
				@view.dinoFullDisplay(
					@table.search(command[1..-1])
				)
			end

			print "Dino Request: "
			command = gets.chomp.split(" ")
		end
	end




end

defacto = DasController.new
defacto.run