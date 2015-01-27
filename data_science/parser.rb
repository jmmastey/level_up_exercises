require 'json'

class Parser
  class << self
    def parse(file)
      raise ArgumentError unless File.exist?(file)
      JSON.parse(File.read(file))
    end

    def counts(data)
      cohort_names(data).each_with_object({}) do |cohort_name, counts|
        new_cohort = Cohort.new(data, cohort_name).count_events
        counts.merge!(new_cohort)
      end
    end

    def cohort_names(data)
      data.map { |event| event['cohort'] }.uniq
    end
  end
end
