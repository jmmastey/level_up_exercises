require_relative 'lib/cohort_loader'
require_relative 'lib/analyzer'

filename = 'data_export_2014_06_20_15_59_02.json'

loader = CohortLoader.new(filename)
loader.load

values = {}
values['A'] = {
  pass: loader.conversions('A'),
  fail: (loader.sample_size('A') - loader.conversions('A')),
}

values['B'] = {
  pass: loader.conversions('B'),
  fail: (loader.sample_size('B') - loader.conversions('B')),
}

analyzer = Analyzer.new(values)

puts analyzer.winner?
