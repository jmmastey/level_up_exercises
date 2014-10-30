
require 'csv'

require_relative 'option_parser.rb'
require_relative 'utility.rb'

class Dinodex
  options = OptionParser.parse(ARGV)

  dino_array = []
  file_array = options.files.sort

  file_array=Utility.verify_file(file_array)

  #look into this
  Utility.read_in(file_array, dino_array)

  #look into this one too
  Utility.pass_off_filters(options, dino_array)

  Utility.print(dino_array)
end
