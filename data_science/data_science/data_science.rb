require 'json'
require 'abanalyzer'

class DataScience
  DEFUALT_COHORT_JSON_PATH = 'split_data/data_export_2014_06_20_15_59_02.json'
  AB_CONFIDENCE = 0.95

  attr_reader :cohort_a, :cohort_b

  def initialize(cohort_a_name, cohort_b_name)
    @cohort_a_name = cohort_a_name
    @cohort_b_name = cohort_b_name
    reset_cohort_data
  end

  def cohort_results
    results = {}
    results[@cohort_a_name.to_sym] = cohort_a.result_val
    results[@cohort_b_name.to_sym] = cohort_b.result_val
    { group: results }
  end

  def reset_cohort_data
    @cohort_a = Cohort.new
    @cohort_b = Cohort.new
  end

  def load_cohort_json(path = DEFUALT_COHORT_JSON_PATH)
    json_file = File.read path
    cohort_entries = JSON.parse(json_file, symbolize_names: true)
    cohort_entries.each(&method(:add_cohort_entry))
  end

  def add_cohort_entry(entry)
    if entry[:cohort] == @cohort_a_name
      cohort_a.insert entry
    elsif entry[:cohort] == @cohort_b_name
      cohort_b.insert entry
    end
  end

  def sample_size
    cohort_a.num_entries + cohort_b.num_entries
  end

  def cohort_a_conversion_rate
    conversion_rate_for cohort_a
  end

  def cohort_b_conversion_rate
    conversion_rate_for cohort_b
  end

  def cohort_leader_confidence
    ABAnalyzer::ABTest.new(cohort_results).chisquare_p
  end

  private

  def conversion_rate_for(cohort)
    ABAnalyzer.confidence_interval(
      cohort.result_val,
      cohort.num_entries,
      AB_CONFIDENCE,
    )
  end
end
