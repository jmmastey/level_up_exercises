module DataScience
  class Test
    attr_reader :results, :data

    def initialize(sample_data)
      @data = sample_data
    end

    def execute
      @results = { status: :OK, groups: {} }
      self
    end
  end
end
