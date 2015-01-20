require_relative "a_b_split_test.rb"
require_relative "cohort.rb"
require_relative "a_b_data_summary.rb"

example_test = ABSplitTest.new(ABDataSummary.new("source_data.json"))
puts "\nExample with source_data.json file:\n\n"
puts "The winner is: #{example_test.test_winner}\n\n"
puts "The confidence level is: #{example_test.confidence_level}\n\n"
puts example_test.to_s
