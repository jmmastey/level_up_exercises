require_relative 'test_data_list'
require_relative 'cohort'
class Calculator
  attr_accessor :test_data_list, :cohorts

  def initialize(filepath)
    @test_data_list = TestDataList.new(filepath).data
    setup_cohorts(test_data_list)
  end

  def calculate_stats
    sample_sizes = sample_size_data
    conversions = conversions_data
    conversion_rates = conversion_rates_data

    print_stats(sample_sizes, conversions, conversion_rates)
  end

  def conversions_data
    Hash[cohorts.map { |cohort| [cohort.name, cohort.conversion_count] }]
  end

  def conversion_rates_data
    Hash[cohorts.map { |cohort| [cohort.name, cohort.conversion_rate] }]
  end

  def sample_size_data
    Hash[cohorts.map { |cohort| [cohort.name, cohort.sample_size] }]
  end

  def confident?
    values = {}
    values[:agroup] = setup_confidence_hash(cohorts.first)
    values[:bgroup] = setup_confidence_hash(cohorts.last)

    ABAnalyzer::ABTest.new(values).different?
  end

  private

  def setup_cohorts(test_data_list)
    cohort_names = test_data_list.map(&:cohort).uniq
    raise 'Only 2 Cohorts allowed!' if cohort_names.count != 2
    self.cohorts = cohort_names.map { |name| Cohort.new(name, test_data_list) }
  end

  def setup_confidence_hash(cohort)
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
