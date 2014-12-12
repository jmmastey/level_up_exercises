# require 'data_parser'
# require 'cohort'
require 'json'

class Loader
  attr_reader :file_contents
  
  def initialize(filepath)
    @filepath = filepath
    @file_contents = File.read(@filepath)
    parse
  end

  def parse
    "Parse method called"
  end

end
