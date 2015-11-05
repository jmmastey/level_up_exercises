require 'json'
require 'pp'

require 'data_science/cohort_factory'
require 'data_science/ab_test'

module DataScience
  class Base
    def initialize(cohort_factory = CohortFactory.new, ab_test = ABTest.new)
      @cohort_factory = cohort_factory
      @ab_test = ab_test
    end

    def parse_test_results(cohort_results_filename)
      cohort_results = deserialize_cohort_file(cohort_results_filename)
      cohorts = @cohort_factory.from_hash_array(cohort_results)

      @ab_test.parse_test_results(cohorts.fetch(:A), cohorts.fetch(:B))
    end

    private

    def deserialize_cohort_file(cohort_results_filename)
      cohort_results_file = File.read(cohort_results_filename)
      JSON.parse(cohort_results_file, symbolize_names: true)
    end
  end
end
