class Cohort
  HIT_VAL    = 1
  MISSED_VAL = 0

  attr_reader :dates, :results, :result_val

  def initialize
    @dates      = []
    @results    = []
    @result_val = 0
  end

  def num_entries
    @results.size
  end

  def insert(entry)
    @dates << entry[:date]
    @results << entry[:result]
    @result_val += entry[:result]
  end
end
