class Data
  attr_reader :cohort, :result
  puts "hi"

  def initialize(cohort, result)
    @cohort = cohort
    @result = result
  end
end
