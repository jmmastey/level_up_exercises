require 'csv'

class DasTable
	attr_reader :headers, :table
	include DasLogic

	def initialize
		@headers = []
		@table = []
		scan_csv
	end

  def scan_csv
    Dir['./dino_fact_csvs/*'].each do |csv_file_path|
      # this should leverage csv headers
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

#tb = DasTable.new
