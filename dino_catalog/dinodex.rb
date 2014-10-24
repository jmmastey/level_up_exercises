
require 'csv'
require_relative 'dino.rb'
require_relative 'filter.rb'
require_relative 'optparse.rb'
require_relative 'utility.rb'

class Dinodex

  options = Optparse.parse(ARGV)

  my_array=[]

  Utility.verify_file(file_array=options.files.sort!)

  Utility.read_in(file_array, my_array)

  Utility.pass_off_filters(options, my_array)

  Utility.print(my_array)

end
