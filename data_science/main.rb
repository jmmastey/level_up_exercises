require_relative "./view_parser"
require_relative "./binomial_data_set"
require_relative "./confidence_interval"
require_relative "./chi_squared"
require_relative "./appview"

def main
  text = File.read("source_data.json")

  views = ViewParser.new.parse(text)

  dataset = BinomialDataSet.new(
    group_field: :id, result_field: :purchased,
    data: views
  )

  chi_squared = ChiSquared.new(dataset: dataset)

  appview = ApplicationView.new

  puts appview.dataset_message(dataset)
  puts appview.interval_table(dataset)
  puts appview.chi_squared_results(chi_squared)
end

main
