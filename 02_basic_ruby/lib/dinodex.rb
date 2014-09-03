class Dinodex
	def initialize(output)
		@output = output
	end
	
	def start
		@output.puts 'Welcome to Dinodex'
		@output.puts 'Enter your selection:'
	end
	
	def findCSVfiles(directory)
		@output.puts 'Finding CSV files in ' + directory
		Dir.entries(directory).select{|f| File.extname(f) == '.csv'}.each do |f|
			@output.puts 'Found ' + File.basename(f)
		end
	end
	
end