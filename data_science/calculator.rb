require_relative 'test_data'
require_relative 'cohort'
class Calculator
  attr_accessor :test_data, :cohorts

  def initialize(filepath)
    @test_data = TestData.new(filepath).data
    setup_cohorts(test_data)
  end

  def calculate_stats
    print_stats(sample_size, conversions, conversion_rates)
  end

  def conversions
    Hash[cohorts.map { |cohort| [cohort.name, cohort.conversion_count] }]
  end

  def conversion_rates
    Hash[cohorts.map { |cohort| [cohort.name, cohort.conversion_rate] }]
  end

  def sample_size
    Hash[cohorts.map { |cohort| [cohort.name, cohort.sample_size] }]
  end

  def confident?
    values = {}
    values[:agroup] = setup_confidence(cohorts.first)
    values[:bgroup] = setup_confidence(cohorts.last)

    ABAnalyzer::ABTest.new(values).different?
  end

  private

  def setup_cohorts(test_data)
    cohort_names = test_data.map(&:cohort).uniq
    raise 'Only 2 Cohorts allowed!' if cohort_names.count != 2
    self.cohorts = cohort_names.map { |name| Cohort.new(name, test_data) }
  end

  def setup_confidence(cohort)
    {
      visitors: cohort.sample_size,
      converted: cohort.conversion_count,
    }
  end

  def print_stats(sample_sizes, conversions, conversion_rates)
    puts ["Cohort A has a sample size of #{sample_sizes[:A]}",
          "Cohort A has #{conversions[:A]} conversions",
          "Cohort A has a conversion rate between: #{conversion_rates[:A][0]} and #{conversion_rates[:A][1]}",
          "",
          "Cohort B has a sample size of #{sample_sizes[:B]}",
          "Cohort B has #{conversions[:B]} conversions",
          "Cohort B has a conversion rate between: #{conversion_rates[:B][0]} and #{conversion_rates[:B][1]}",
          ""].join("\n")

    print_confidence
  end

  def print_confidence
    if confident?
      puts "The two sets are statistically different enough to matter"
    else
      puts "The two sets are not statistically different enough to matter"
    end
  end
end
