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

  intervals = dataset.groups.inject({}) do |mapped_hash, (id, group)|
    mapped_hash[id] = group.confidence_interval
    mapped_hash
  end

  chi_squared = ChiSquared.new(dataset: dataset)

  appview = AppView.new

  puts appview.dataset_message(dataset)
  puts appview.interval_table(intervals)
  puts appview.chi_squared_results(chi_squared)
end

main
