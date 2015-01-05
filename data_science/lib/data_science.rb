require 'json'

class DataScience
  attr_reader :conversions
  
  # TODO: make sure the data loading is abstracted from the main 
  # calculation code
  def initialize(raw_json)
    @sample = JSON.parse(raw_json)   
    @conversions = Hash.new(0)
    
    @sample.each do |current_sample|
      if current_sample['result'].to_i > 0
        @conversions[current_sample['cohort']] += current_sample['result']
      end
    end 
  end
  
  def sample_size
    @sample.length
  end
end
