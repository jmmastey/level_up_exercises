require 'json'

class Loader
	  
  attr_reader :data_hash
  
  def initialize(filename)
    @filename = filename
    @file = File.read(@filename)
  end		
  
  def parse_json			
    JSON.parse(@file)	
  end
end



