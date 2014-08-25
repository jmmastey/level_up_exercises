class ParseFiles

  attr_accessor :parse_csv

  def initialize(parse_csv=[])
    self.parse_csv = parse_csv
  end

  def parse_files(filenames)
    filenames.each do |filename|
      CSV.foreach(filename, :headers => true, :header_converters => :downcase) do |row|
        parse_csv << row.to_hash.reject{ |k,v| v==nil }

      end
    end
    parse_csv

  end
end