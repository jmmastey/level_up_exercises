class DataEntry
  attr_reader :cohort, :date, :result

  def initialize(data = {})
    map_fields(data)
  end

  def conversion?
    @result == 1
  end

  private

  def map_fields(data)
    data.each { |key, value| instance_variable_set("@#{key}", value) }
  end
end
