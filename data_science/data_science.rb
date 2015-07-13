require 'json'
require 'abanalyzer'
require './cohort.rb'

class DataScience
  attr_accessor :cohorts, :sample_size, :winner, :test

  def initialize(json_file)
    json_data = open(json_file, &:read)
    json = JSON.parse(json_data).to_a
    @sample_size = json.count

    raw_cohorts = json.partition { |item| item['cohort'].downcase == 'a' }
    @cohorts = raw_cohorts.map { |cohort_info| Cohort.new(cohort_info) }

    run_chi_square_test
  end

  def report_chi_square_results
    print "Better than random? #{@test.different?}"

    p = @test.chisquare_p.round(3)
    puts " (#{p} #{p < 0.05 ? '<=' : '>='} 0.05)"
  end

  def report_winner
    if @winner.nil?
      puts "The chi square test results are not significant enough."
    else
      puts "#{@winner.name} is the winner!"
    end
  end

  def report_cohorts
    @cohorts.each(&:formatted_report)
  end

  def report_all
    report_cohorts
    report_chi_square_results
    report_winner
  end

  private

  def chi_square_test
    values = @cohorts.inject({}) do |vals, cohort|
      vals[cohort.name] = cohort.conversion_hash
      vals
    end
    ABAnalyzer::ABTest.new(values)
  end

  def select_winner(test)
    return nil unless test.different?

    @winner = @cohorts.max do |cohort|
      cohort.conversion_rate
    end
  end

  def run_chi_square_test
    @test = chi_square_test
    @winner = select_winner(test)
  end
end

# DataScience.new('data_export_2014_06_20_15_59_02.json').report_all
