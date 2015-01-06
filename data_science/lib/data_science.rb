require 'json'

class DataScience
  attr_reader :cohorts

  autoload :Cohort, 'data_science/cohort'
  
  # TODO: make sure the data loading is abstracted from the main 
  # calculation code
  def initialize(raw_json)
    load_raw_json(raw_json)
    
    @cohorts = {}
    
    import_trial_and_conversion_counts
  end
  
  def sample_size
    @sample.length
  end

  
private
  
  def import_trial_and_conversion_counts
    @sample.each do |current_sample|
      current_cohort = current_sample['cohort']

      @cohorts[current_cohort] ||= DataScience::Cohort.new(current_cohort)
      @cohorts[current_cohort].add_sample(current_sample['result'])
    end 
  end
  
  def load_raw_json(raw_json)
    @sample = JSON.parse(raw_json)   
  end
end
