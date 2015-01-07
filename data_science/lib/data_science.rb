class DataScience
  attr_reader :cohorts

  require 'data_science/cohort'

  # TODO: make sure the data loading is abstracted from the main
  # calculation code
  def initialize(sample)
    @sample  = sample
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
end
