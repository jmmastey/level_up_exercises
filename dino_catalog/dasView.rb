class DasView

	def headerDisplay(headers)
		headers.each do |header|
			puts header
		end
	end

	def dinoFullDisplay(dinos)
		dinos.each do |dino|
			dino.each do |k, v|
				print "#{k}: #{v} "
			end
			puts
		end
	end

	def optionsDisplay
			puts "-h or help: access this help menue"
			puts "-e or exit: exit the program"
			puts "-l or list: view a list of all dinos"
			puts "-c or categories: view a list of all search categories"
			puts "-s or search category:<term> category:<term>... : view a filtered list of dinos"
	end

	def greetingDisplay
		puts "Welcome to Di-Facto, your presumed source for prehistoric points of interest"
	end

end