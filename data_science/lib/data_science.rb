require 'json'

class DataScience
  # TODO: make sure the data loading is abstracted from the main 
  # calculation code
  def initialize
    raw_json = File.read(File.expand_path("../data/source_data.json"))
    data     = JSON.parse(raw_json)
    
    puts data
  end  
end
