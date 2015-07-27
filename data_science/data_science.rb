require 'json'
require 'abanalyzer'
require './cohort.rb'

class DataScience
  attr_accessor :cohorts, :sample_size

  def initialize(json_file)
    json_data = open(json_file, &:read)
    json = JSON.parse(json_data).to_a

    @sample_size = json.count
    @cohorts = make_cohorts(json)
  end

  def winner
    return nil unless chi_square_test.different?
    @winner = @cohorts.max_by(&:conversion_rate)
  end

  def report_all
    report_cohorts
    report_chi_square_results
    report_winner
  end

  private

  def report_chi_square_results
    test = chi_square_test
    print "Better than random? #{test.different?}"

    p = test.chisquare_p.round(3)
    puts " (#{p} #{p < 0.05 ? '<=' : '>='} 0.05)"
  end

  def report_winner
    if winner
      puts "#{winner.name} is the winner!"
    else
      puts "The chi square test results are not significant enough."
    end
  end

  def report_cohorts
    @cohorts.each { |cohort| puts "#{cohort}\n" }
  end

  def make_cohorts(sample_data)
    raw_cohorts = sample_data.partition do |sample|
      sample['cohort'].downcase == 'a'
    end

    raw_cohorts.map do |info|
      Cohort.new(info[0]['cohort'], info)
    end
  end

  def chi_square_test
    values = @cohorts.inject({}) do |vals, cohort|
      vals[cohort.name] = cohort.conversion_hash
      vals
    end
    ABAnalyzer::ABTest.new(values)
  end
end

DataScience.new('data_export_2014_06_20_15_59_02.json').report_all
