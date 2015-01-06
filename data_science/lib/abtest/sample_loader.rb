require "json"

module ABTest
  class SampleLoader
    def self.load(samples)
      JSON.load(samples).map do |sample|
        Sample.new(sample["date"], sample["cohort"], sample["result"])
      end
    end
  end
end
