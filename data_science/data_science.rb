require_relative "data_analyzer"
require_relative "data_loader"

puts
puts "****************"
puts "* Data Science *"
puts "****************"
puts

loader = DataLoader.new(
  file: File.expand_path("../data/data_export_2014_06_20_15_59_02.json",
                         __FILE__))

analyzer = DataAnalyzer.new(loader)
analyzer.load(a_group: { cohort: "A" }, b_group: { cohort: "B" })

puts "Total Sample Size: #{analyzer.sample_size}"
puts "Significant? #{analyzer.significant? ? 'Yes' : 'No'}"
puts "P-Value: #{analyzer.p_value.round(3)}"
puts

%w(A B).each do |group_letter|
  group = "#{group_letter.downcase}_group".to_sym

  puts "-- Cohort #{group_letter} --"
  puts "Samples: #{analyzer.sample_size(group)}"
  puts "Conversions: #{analyzer.conversion_count(group)}"
  interval = analyzer.confidence_interval(group, 0.95)
  spread = (interval[:high] - interval[:low]) / 2
  puts "Conversion Rate: #{analyzer.conversion_rate(group).round(4)} " \
       "\u00B1#{spread.round(4)}"
  puts
end
