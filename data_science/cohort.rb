require 'abanalyzer'
require 'pry'

class Cohort
  attr_accessor :name, :records, :conversions
  Record = Struct.new(:result, :date)

  CONFIDENCE_INTERVAL_ACCURACY = 0.95

  def initialize(name)
    @name = name
    @records = 0
    @conversions = 0
  end

  def insert_record(record)
    validate_hash(record)
    validate_cohort(record)
    record = convert_record(record)
    if record[:result] == 1
      @conversions += 1
    end
    @records += 1
  end

  def conversion_rate
    interval = ABAnalyzer.confidence_interval(@conversions, @records,
                                             CONFIDENCE_INTERVAL_ACCURACY)
    interval.map { |val| (val * 100).round(2) }
  end

  def to_s
    [
      "Cohort: #{name}",
      "Total Records: #{records}",
      "Total Conversions: #{conversions}",
      "Conversion Interval: #{conversion_rate[0]}% to #{conversion_rate[1]}%"
    ].join("\n")
  end

  private

  def validate_hash(record)
    return if [:date, :result, :cohort].all? { |k| record.key?(k) }
    raise ArgumentError, "Invalid Record"
  end

  def validate_cohort(record)
    raise NameError, "Wrong Cohort" if record[:cohort] != @name
  end

  def convert_record(record)
    Record.new(record[:result], record[:date])
  end
end
