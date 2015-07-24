require 'abanalyzer'
require_relative 'lib/cohort_loader'

filename = 'data_export_2014_06_20_15_59_02.json'

loader = CohortLoader.new(filename)
loader.load

loader.to_ab_format

analyzer = ABAnalyzer::ABTest.new(loader.to_ab_format)
puts analyzer.different?