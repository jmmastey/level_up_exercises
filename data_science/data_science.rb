require 'json'

class DataScience
  attr_accessor :cohorts, :sample_size

  def initialize(json_file)
    json_data = open(json_file).read
    json = JSON.parse(json_data).to_a
    @sample_size = json.count

    parts = json.partition { |item| item['cohort'] == 'A' }
    @cohorts = Hash[*%w(A B).zip(parts).flatten(1)]
  end

  def cohort_conversions(cohort_name)
    cohort = @cohorts[cohort_name]
    cohort.inject(0) { |sum, data| sum + data['result'] }
  end

  def cohort_stats(cohort_name)
    conv = cohort_conversions(cohort_name)
    sample = @cohorts[cohort_name].count

    [conv, sample]
  end

  # 1. Total sample size and number of conversions for each cohort.
  def report_sample_sizes
    @cohorts.keys.each do |name|
      stats = cohort_stats(name)

      puts "Cohort #{name}: #{stats[0]} / #{stats[1]}"
    end
  end

  def calc_mean_error(cohort_name)
    stats = cohort_stats(cohort_name)

    p = (stats[0].to_f / stats[1].to_f)
    se = (2 * Math.sqrt(p * (1 - p) / @sample_size.to_f))

    [p, se]
  end

  # 2. Conversion rate (w/ error bars) for each cohort with a 95% confidence.
  # Square root of (p * (1-p) / n)
  def report_mean_error
    @cohorts.keys.each do |name|
      p, se = calc_mean_error(name)

      puts "Conversion Rate #{name} = #{p}"
      puts "Standard Error #{name}  = #{se}"
    end
  end

  def calc_confidence(cohort_name)
    p, se = calc_mean_error(cohort_name)

    [p - se, p, p + se].map{ |num| num.round(3) }
  end

  # 3. Confidence level that the current leader is in fact better than random.
  # (done in confidence)
  def report_confidence
    @cohorts.keys.each do |name|
      low, p, high = calc_confidence(name)

      puts "95% Confidence Interval for Cohort #{name}: "
      puts "|(#{low})--- (#{p}) ---(#{high})|"
    end
  end

  def report_all
    puts "Sample size: #{@sample_size}"
    report_sample_sizes
    report_mean_error
    report_confidence
  end
end

#DataScience.new('data_export_2014_06_20_15_59_02.json').report_all
