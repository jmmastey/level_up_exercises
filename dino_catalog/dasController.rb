

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
		while true
			print "Dino Request: "
			command = gets.chomp.split(" ")

			p command[0]

			case command[0]
			when "-e", "exit"
				break

			when "-h", "help"
				@view.optionsDisplay

			when "-l", "list"


			when "-c", "categories"


			when "-s", "search"

			end

		end
	end




end

defacto = DasController.new
defacto.run