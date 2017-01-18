require_relative 'dino_header_converters.rb'

class FileParser

  def self.parse(filenames)
    parsed_csv = []
    filenames.each do |filename|
     CSV.foreach(filename, #:headers => true) do |row|
                  :header_converters => [:weight_converter, :carnivore_converter, :name_converter, :downcase],
                  :converters => [:diet_converter], :headers => true) do |row|
     parsed_csv << row.to_hash.reject { |_k,v| v==nil }
    end
  end
  parsed_csv
  end
end
