require 'json'

class DataScience
  # TODO: make sure the data loading is abstracted from the main 
  # calculation code
  def initialize(raw_json)
    @sample = JSON.parse(raw_json)    
  end
  
  def sample_size
    @sample.length
  end
end
