require_relative 'datum'

class Dataset
  CONFIDENCE = 1.96
  attr_accessor :results

  def initialize(data)
    @results = []
    data.each { |line| @results << Datum.new(line) }
  end

  def total_sample_size
    @results.length
  end

  def total_in_group(cohort)
    count = 0

    @results.each do |result|
      count += 1 if result.cohort == cohort
    end

    count
  end

  def number_of_conversions(cohort)
    count = 0

    @results.each do |result|
      count += 1 if result.cohort == cohort && result.result == 1
    end

    count
  end

  def percentage_of_conversion(cohort)
    (number_of_conversions(cohort).to_f / total_in_group(cohort).to_f).round(4)
  end

  def calculate_standard_error(cohort)
    p = percentage_of_conversion(cohort)
    n = total_in_group(cohort)

    ((Math.sqrt(p * (1 - p) / n)) * CONFIDENCE).round(4)
  end
end

require_relative 'json_loader'

json = JSONLoader.new('source_data.json').fetch_data
dataset = Dataset.new(json)
puts dataset.calculate_standard_error('A')# * 100
puts dataset.calculate_standard_error('B')# * 100
