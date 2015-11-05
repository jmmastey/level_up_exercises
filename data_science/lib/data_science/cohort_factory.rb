require 'data_science/cohort'

module DataScience
  class CohortFactory
    CONVERSION_RESULT = 1
    private_constant :CONVERSION_RESULT

    def from_hash_array(results)
      aggregate_results = results
        .group_by { |r| r.fetch(:cohort) }
        .map { |k, v| [k.to_sym, cohort_for(v)] }

      Hash[aggregate_results]
    end

    private

    def cohort_for(hash_array)
      size = hash_array.size
      conversions = hash_array.count { |h| h.fetch(:result) == CONVERSION_RESULT }

      Cohort.new(size - conversions, conversions)
    end
  end
end
