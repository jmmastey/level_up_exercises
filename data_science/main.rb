require_relative "load_json_stats"
require_relative "compare_stats"

data = LoadJsonStats.get_data_stats("source_data.json")

puts "Data Stats:"
puts data.join("\n")
compare = CompareStats.new(*data)
puts "Leader: #{compare.leader.name}"
puts "Probablity level: #{compare.probabilty_level}"
puts "Clear winner? #{compare.significant_difference?}"
