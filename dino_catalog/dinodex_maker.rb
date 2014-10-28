require_relative 'csvparse'
require_relative 'dinodex'

class DinodexMaker
  def make_dinodex(filesArray)
    parser = CSVParse.new
    dinosaurs = []
    filesArray.each do |file|
      dinosaurs = parser.parse_csv(file)
    end
  Dinodex.new(dinosaurs)
  end
end
