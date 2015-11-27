

require_relative "dasLogic"
require_relative "dasView"
require_relative "dasTable"

class CatalougeController
	def initialize
		@table = DasTable.new
		@view = DasView.new
	end

	def run
		@view.greeting_display
		command = ["help"]
		while true		

			case command[0]
			when "-e", "exit"
				break
			when "-h", "help"
				@view.options_display
			when "-l", "list"
				@view.dino_full_display(@table.table)
			when "-c", "categories"
				@view.header_display(@table.headers)

			when "-s", "search"
				@view.dino_full_display(
					@table.search(
						parse_search_terms(command[1..-1])
					)
				)
			end

			print "Dino Request: "
			command = gets.chomp.split(" ")
		end
	end

	def parse_search_terms(search_terms)
		rtn = {}
		search_terms.each do |term|
			arg = term.split(":")
			rtn[arg[0]] = arg[1]
		end
		rtn
	end


end

defacto = CatalougeController.new
defacto.run