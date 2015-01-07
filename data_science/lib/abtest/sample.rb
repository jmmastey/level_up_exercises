module ABTest
  class Sample
    attr_accessor :date, :cohort, :result

    def initialize(date, cohort, result)
      @date = date
      @cohort = cohort
      @result = result
    end

    def ==(other)
      date == other.date &&
        cohort == other.cohort &&
        result == other.result
    end
  end
end
