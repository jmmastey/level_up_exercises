require_relative 'csvparse'
require_relative 'dinodex'

class DinosaurParser
  attr_reader :files

  def initialize(files)
    @files = files
  end

  def parse_all_files
    parser = CSVParse.new
    dinosaurs = []
    files.each do |file|
      dinosaurs = parser.parse_csv(file) if File.exist?(file) \
                && file.split(//).last(3).join.casecmp('csv')
    end
    Dinodex.new(dinosaurs)
  end
end
