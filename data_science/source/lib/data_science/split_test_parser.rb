module DataScience
  class SplitTestParser < Parser
    def self.parse(input_data)
      input_data.inject({}) do |groups, entry|
        cohort = entry[:cohort].to_sym
        target = entry[:result] > 0 ? :hits : :misses
        increment_group(groups, cohort, target)
      end
    end

    def self.increment_group(groups, cohort, target)
      groups[cohort] ||= { hits: 0, misses: 0, total: 0 }
      groups[cohort][target] += 1
      groups[cohort][:total] += 1
      groups
    end
  end
end
