require 'json'

class SplitTestData
  attr_reader :data

  def initialize(json_file)
    @data = JSON.parse(file_contents(json_file))
  end

  def successes
    data_summary = Hash.new(0)
    @data.each do |row|
      data_summary[row["cohort"]] += row["result"]
    end
    data_summary
  end

  def attempts
    data_summary = Hash.new(0)
    @data.each do |row|
      data_summary[row["cohort"]] += 1
    end
    data_summary
  end

  def conversion_rates
    goals = successes
    visitors = attempts
    conversion_percentages = Hash.new

    goals.each do |cohort, successes|
      conversion_percentages[cohort] = successes/visitors[cohort]
    end
    conversion_percentages
  end

  def file_contents(file_path)
    File.open(file_path, 'r') {|f| f.read }
  end
end