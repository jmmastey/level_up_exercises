require 'abanalyzer'
require 'pry'

class Cohort
  attr_accessor :name, :records, :conversions
  Record = Struct.new(:result, :date)

  def initialize(name)
    @name = name
    @records = []
    @conversions = 0
  end

  def insert_record(record)
    validate_hash(record)
    validate_cohort(record)
    record = convert_record(record)
    if record[:result] == 1
      @conversions = @conversions + 1
    end
    @records.push(record)
  end

  def conversion_rate
    interval = ABAnalyzer.confidence_interval(@conversions, @records.size, 0.95)
    interval.map { |val| (val * 100).round(2) }
  end

  def to_s
    string = ""
    string << "Cohort: #{@name}\n"
    string << "Total Records: #{@records.size}\n"
    string << "Total Conversions: #{@conversions}\n"
    string << "Conversion Interval: #{conversion_rate[0]}% to "
    string << "#{conversion_rate[1]}%\n"
  end

  private

  def validate_hash(record)
    unless record.include?(:date) &&
           record.include?(:result) &&
           record.include?(:cohort)
      raise ArgumentError, "Invalid Record"
    end
  end

  def validate_cohort(record)
    raise NameError, "Wrong Cohort" if record[:cohort] != @name
  end

  def convert_record(record)
    Record.new(record[:result], record[:date])
  end
end
