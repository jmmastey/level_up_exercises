require_relative 'split_test'

cohorts = Parser.parse("./source_data.json") #=> [cohortA, cohortB]
split_test =  SplitTest.new(*cohorts)
# split_test.different?.report
split_test.different?
