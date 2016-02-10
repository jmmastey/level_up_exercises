require 'csv'

class DinoCsvParser

  def self.from_directory(dir_path = "../dino_fact_csvs")
    ary = [] # each_with_object([]) doesn't work w/ += ary
    Dir["#{dir_path}/*"].each do |file_path|
      ary += DinoCsvParser.from_file(file_path)
    end
    ary
  end

  def self.from_file(file_path)
    ary = []
    CSV.foreach(file_path,
                converters: :numeric,
                headers: true,
                :header_converters => lambda {|h| h.downcase}
                ) do |row|
                  ary << row.to_h
    end
    ary
  end

end

# test = DinoCsvParser.from_directory
# puts test.count