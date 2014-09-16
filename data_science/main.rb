require_relative "./viewparser"
require_relative "./binomialdataset"
require_relative "./confidenceinterval"
require_relative "./chisquare"
require_relative "./appview"

def main
  text = File.read("source_data.json")

  views = ViewParser.new.parse(text)

  dataset = BinomialDataSet.new(
    group_field: :id, result_field: :purchased,
    data: views
  )

  intervals = dataset.groups.each_value.map do |group|
    [group.id, group.confidence_interval]
  end

  chi_square = ChiSquare.new(dataset: dataset)

  appview = AppView.new

  puts appview.dataset_message(dataset)
  puts appview.interval_table(intervals)
  puts appview.chi_square_results(chi_square)
end

main
