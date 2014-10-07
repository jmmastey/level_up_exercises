class Datum
  attr_accessor :date, :cohort, :result

  def initialize(properties)
    properties.each { |field, value| method("#{field}=").call(value) }
  end
end
