require_relative "dasScanner"

class DasTable
	def initialize
		@headers = []
		@table = []
		setTable
	end

	def setTable
		# sc = DasScanner.new
		Dir['./dino_fact_csvs/*'].each do |csvFilePath|
    	i = 0
    	headers = ""
    	CSV.read(csvFilePath).each do |line|
	    	if i == 0
	    		headers = line
	    		self.updateHeaders(line)
	    	else
	    		self.addLine(line, headers)
	    	end
	    	i += 1
	    end
		end
	end

	def updateHeaders(newHeaders)
		@headers = newHeaders.map(&:upcase) | @headers
	end

	def addLine(line, headers)
		dino = {}
		headers.each_with_index do |header, i|
			dino[header] = line[i]
		end
		@table << dino
	end


end

tb = DasTable.new
