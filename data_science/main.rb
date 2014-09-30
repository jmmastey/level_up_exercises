require_relative "./view_parser"
require_relative "./binomial_data_set"
require_relative "./confidence_interval"
require_relative "./chi_squared"
require_relative "./appview"

def main
  dataset = parse_dataset
  chi_squared = ChiSquared.new(dataset: dataset)
  print_results(dataset, chi_squared)
end

def parse_dataset
  text = File.read("source_data.json")
  views = ViewParser.new.parse(text)
  BinomialDataSet.new(
    group_field: :id, result_field: :purchased,
    data: views
  )
end

def print_results(dataset, chi_squared)
  appview = ApplicationView.new
  puts appview.dataset_message(dataset)
  puts appview.interval_table(dataset)
  puts appview.chi_squared_results(chi_squared)
end

main
