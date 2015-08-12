require_relative 'cohort'
require_relative 'analyzer'
require_relative 'dataloader'

filename = "data_export_2014_06_20_15_59_02.json"
cohorts = DataLoader.load_json(filename)
analyzer = Analyzer.new(cohorts)
analyzer.print_results
