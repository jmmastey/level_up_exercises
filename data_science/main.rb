require_relative 'lib/split_test'
require_relative 'lib/parser'

cohorts = Parser.parse("./source_data.json") # => [cohortA, cohortB]
split_test =  SplitTest.new(*cohorts)
puts split_test.different?
puts split_test.chisquare_p_value

# Is a nice string implementation necessary?
# split_test.report
