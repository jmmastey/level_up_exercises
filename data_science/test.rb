require './splittest'

splittest = SplitTest.new('data/test_data.json')
splittest.generate_report
p splittest.cohorts
