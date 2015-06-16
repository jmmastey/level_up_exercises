module TestDataFactory
  def self.small_sample(stub = [])
    12.times { stub << hash_entry('A', 0) }
    8.times { stub << hash_entry('A', 1) }
    20.times { stub << hash_entry('B', 0) }
    10.times { stub << hash_entry('B', 1) }
    stub
  end

  def self.invalid_cohort_sample(stub = [])
    12.times { stub << hash_entry('A', 0) }
    8.times { stub << invalid_cohort_entry('A', 1) }
    20.times { stub << hash_entry('B', 0) }
    10.times { stub << hash_entry('B', 1) }
    stub
  end

  def self.invalid_result_sample(stub = [])
    12.times { stub << hash_entry('A', 0) }
    8.times { stub << invalid_result_entry('A', 1) }
    20.times { stub << hash_entry('B', 0) }
    10.times { stub << hash_entry('B', 1) }
    stub
  end

  def self.invalid_value_sample(stub = [])
    12.times { stub << hash_entry('A', 0) }
    8.times { stub << hash_entry('A', 3) }
    20.times { stub << hash_entry('B', -2) }
    10.times { stub << hash_entry('B', 1) }
    stub
  end

  def self.confident_sample(stub = [])
    275.times { stub << hash_entry('A', 0) }
    225.times { stub << hash_entry('A', 1) }
    50.times { stub << hash_entry('B', 0) }
    450.times { stub << hash_entry('B', 1) }
    stub
  end

  def self.inconclusive_sample(stub = [])
    275.times { stub << hash_entry('A', 0) }
    225.times { stub << hash_entry('A', 1) }
    270.times { stub << hash_entry('B', 0) }
    230.times { stub << hash_entry('B', 1) }
    stub
  end

  def self.ninety_percent_sample(stub = [])
    275.times { stub << hash_entry('A', 0) }
    225.times { stub << hash_entry('A', 1) }
    245.times { stub << hash_entry('B', 0) }
    255.times { stub << hash_entry('B', 1) }
    stub
  end

  private

  def self.invalid_cohort_entry(cohort, result)
    {
      group: cohort,
      result: result,
    }
  end

  def self.invalid_result_entry(cohort, result)
    {
      cohort: cohort,
      visits: result,
    }
  end

  def self.hash_entry(cohort, result)
    {
      date: "2014-05-19",
      cohort: cohort,
      result: result,
    }
  end
end
