require 'csv'
module DasScanner

	def set_table
		Dir['./dino_fact_csvs/*'].each do |csv_file_path|
    	i = 0
    	headers = ""
    	CSV.read(csv_file_path).each do |line|
	    	if i == 0
	    		headers = line
	    		self.update_headers(line)
	    	else
	    		self.add_line(line, headers)
	    	end
	    	i += 1
	    end
		end
	end

	def update_headers(new_headers)
		@headers = new_headers.map(&:upcase) | @headers
	end

	def add_line(line, headers)
		dino = {}
		headers.each_with_index do |header, i|
			dino[header] = line[i]
		end
		@table << dino
	end

end