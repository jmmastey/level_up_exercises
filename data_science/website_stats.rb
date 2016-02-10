require './website_data'

class WebsiteStats
  attr_accessor :site_data

  def initialize(visits)
    @site_data = WebsiteData.new(visits)
  end

  def size_of_cohort(cohort)
    @site_data.filtered_size(cohort: cohort)
  end

  def num_of_conversions(cohort)
    @site_data.filtered_size(cohort: cohort, result: 1)
  end

  def num_no_conversions(cohort)
    @site_data.filtered_size(cohort: cohort, result: 0)
  end

  def cohort_values(cohort)
    { not_converted: num_no_conversions(cohort),
      converted: num_of_conversions(cohort) }
  end

  def prep_data
    # Data is prepared according to API https://github.com/bmuller/abanalyzer
    { A: cohort_values("A"), B: cohort_values("B") }
  end
end
