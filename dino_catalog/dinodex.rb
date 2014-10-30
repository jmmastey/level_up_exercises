require 'csv'
require_relative 'option_parser.rb'
require_relative 'utility.rb'

class Dinodex
  options = OptionParser.parse(ARGV)

  file_array = options.files.sort
  file_array = Utility.verify_file(file_array)
  dinos = Utility.read_in(file_array)
  dinos = Utility.pass_off_filters(options, dinos)

  Utility.print(dinos)
end
