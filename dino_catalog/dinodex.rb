
require 'csv'

require_relative 'option_parser.rb'
require_relative 'utility.rb'

class Dinodex
  options = OptionParser.parse(ARGV)

  dino_array = []
  file_array = options.files.sort

  file_array = Utility.verify_file(file_array)

  dino_array = Utility.read_in(file_array, dino_array)

  dino_array = Utility.pass_off_filters(options, dino_array)

  Utility.print(dino_array)
end
