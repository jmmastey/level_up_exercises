require_relative 'CSVParse.rb'

class Dinodex
  def initialize(file)
    parser = CSVParse.new
    parser.parse_csv(file) unless !(File.exist?(file) \
              && file.split(//).last(3).join.casecmp('csv'))
  end
end
