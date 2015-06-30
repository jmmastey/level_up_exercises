require 'json'

class DataScience
  attr_accessor :json, :cohorts, :sample

  def initialize(json_file)
    json_data = open(json_file).read
    @json = JSON.parse(json_data).to_a
    @sample = @json.count

    parts = json.partition { |item| item['cohort'] == 'A' }
    @cohorts = Hash[*%w(A B).zip(parts).flatten(1)]
  end

  def total_sample_size
    puts "Sample size: #{@sample}"
  end

  def cohort_conversions(cohort_name)
    cohort = @cohorts[cohort_name]
    cohort.inject(0) { |sum, data| sum + data['result'] }
  end

  def cohort_stats(cohort_name)
    cconv = cohort_conversions(cohort_name)
    csample = @cohorts[cohort_name].count

    [cconv, csample]
  end

  # 1. Total sample size and number of conversions for each cohort.
  def report_sample_sizes
    @cohorts.keys.each do |cname|
      cstats = cohort_stats(cname)

      puts "Cohort #{cname}: #{cstats[0]} / #{cstats[1]}"
    end
  end

  def calc_mean_error(cohort_name)
    cstats = cohort_stats(cohort_name)

    p = (cstats[0].to_f / cstats[1].to_f).round(5)
    se = (2 * Math.sqrt(p * (1 - p) / @sample.to_f)).round(5)

    [p, se]
  end

  # 2. Conversion rate (w/ error bars) for each cohort with a 95% confidence.
  # Square root of (p * (1-p) / n)
  def report_mean_error
    @cohorts.keys.each do |cname|
      p, se = calc_mean_error(cname)

      puts "Conversion Rate #{cname} = #{p}"
      puts "Standard Error #{cname}  = #{se}"
    end
  end

  def calc_confidence(cohort_name)
    p, se = calc_mean_error(cohort_name)

    low = (p - se).round(3)
    high = (p + se).round(3)

    [low, p, high]
  end

  # 3. Confidence level that the current leader is in fact better than random.
  # (done in confidence)
  def report_confidence
    @cohorts.keys.each do |cname|
      low, p, high = calc_confidence(cname)

      puts "95% Confidence Interval for Cohort #{cname}: "
      puts "|(#{low})--- (#{p}) ---(#{high})|"
    end
  end

  def report_all
    total_sample_size
    report_sample_sizes
    report_mean_error
    report_confidence
  end
end

DataScience.new('data_export_2014_06_20_15_59_02.json').report_all
