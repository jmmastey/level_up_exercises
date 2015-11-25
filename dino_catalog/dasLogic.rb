class DasLogic

	def execute(command, table)
		p command
		case command[0]
		when "-h" || "help"
			return 1
		when "s"
			puts "this is the alt help screen"
		end

	end





end