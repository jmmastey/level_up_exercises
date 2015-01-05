require 'json'

class DataScience
  attr_reader :conversions, :conversion_rates, :trials
  
  # TODO: make sure the data loading is abstracted from the main 
  # calculation code
  def initialize(raw_json)
    load_raw_json(raw_json)
    
    @cohorts = []

    # TODO: go away
    @conversion_rates = {}
    @conversions      = Hash.new(0)
    @trials           = Hash.new(0)
    
    extract_trial_and_conversion_counts
    # calculate_conversion_rates
  end
  
  def sample_size
    @sample.length
  end

  
private
  
  # def calculate_conversion_rates
  #   @trials.each_pair do |cohort, trial_count|
  #     @conversion_rates[cohort] = (conversions[cohort].to_f/trial_count.to_f).round(3)
  #   end
  # end
  
  def extract_trial_and_conversion_counts
    @sample.each do |current_sample|
      @trials[current_sample['cohort']] += 1
    
      if current_sample['result'].to_i > 0
        @conversions[current_sample['cohort']] += current_sample['result']
      end
    end 
  end
  
  def load_raw_json(raw_json)
    @sample  = JSON.parse(raw_json)   
  end
end
