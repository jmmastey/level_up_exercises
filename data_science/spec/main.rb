require_relative 'visitor'
require_relative 'cohort'
require_relative 'parser'
require_relative 'split_test'



cohorts = Parser.parse("./source_data.json") #=> [cohortA, cohortB]

puts SplitTest.new(*cohorts).
