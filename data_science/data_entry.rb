class DataEntry
  attr_reader :cohort, :date, :result

  def initialize(data = {})
    @cohort = data[:cohort]
    @date = data[:date]
    @result = data[:result]
  end

  def conversion?
    @result == 1
  end
end
