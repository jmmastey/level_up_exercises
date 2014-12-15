
require 'abanalyzer'

require_relative 'data.rb'
require_relative 'Dataloader.rb'

class Sample
  def self.percent
    0.95
  end

  def self.find_conversions(group)
    num_convs = number_of_conversions(group)
    vistors = group.length
    [num_convs, vistors]
  end

  def self.find_chi(values)
    tester = ABAnalyzer::ABTest.new values
    chi_percent = tester.chisquare_score.round(2)
    puts "Chi Score:                #{chi_percent}%"
  end

  def self.number_of_conversions(group_in)
    total = 0
    group_in.each do |row|
      total += 1 if row.result == 1
    end
    total
  end

  def self.calc_percent(total, cohort_size)
    ((total.to_f / cohort_size.to_f) * 100.0).round(2)
  end

  def self.find_confidence(num_convs, vistors, percent)
    low, high = ABAnalyzer.confidence_interval(num_convs, vistors, percent)
    high = (high * 100.0).round(2)
    low = (low  * 100.0).round(2)
    [low, high]
  end

  def self.calculate_values(group_in, group_name, values)
    num_convs, vistors = Sample.find_conversions(group_in)
    con_l, con_h = Sample.find_confidence(num_convs, vistors, Sample.percent)
    values[group_name] = { num_convs: num_convs, vistors: vistors }
    { low: con_l, high: con_h }
  end

  def self.determine_leader(values, confidence_array)
    puts
    Sample.find_chi(values)
    puts "Larger of the Two is:     #{confidence_array.max}%"
  end
end

def print(range, confidence, name)
  puts "Name:                     #{name} "
  puts "Conversions:              #{range[:num_convs]}"
  puts "Sample Size:              #{range[:vistors]}"
  percent = Sample.calc_percent(range[:num_convs], range[:vistors])
  puts "Percent:                  #{percent}%"
  puts "Low  Confidence Percent:  #{confidence[:low]}%"
  puts "High Confidence Percent:  #{confidence[:high]}%"
end
