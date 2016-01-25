require './website_data'

class WebsiteStats
  attr_accessor :site_data

  def initialize(array_of_visits)
    @site_data = WebsiteData.new(array_of_visits)
  end

  def size_of_cohort(cohort_name)
    @site_data.filtered_size(cohort: cohort_name)
  end

  def num_of_conversions(cohort_name)
    @site_data.filtered_size(cohort: cohort_name, result: 1)
  end

  def num_no_conversions(cohort_name)
    @site_data.filtered_size(cohort: cohort_name, result: 0)
  end

  def cohort_values(cohort_name)
    results_hash = {}
    results_hash[:not_converted] = num_no_conversions(cohort_name)
    results_hash[:converted] = num_of_conversions(cohort_name)
    results_hash
  end

  def prep_data
    # Data is prepared according to API https://github.com/bmuller/abanalyzer
    { A: cohort_values("A"), B: cohort_values("B") }
  end
end
