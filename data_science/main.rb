require_relative "./viewparser"

def main
  data_path = "source_data.json"
  data = ViewParser.new.parse(data_path)
  dataset = DataSet.new(
    group_field: id, control_id: "A",
    result_field: :purchased, data: data
  )

  intervals = %w(A B).map do |group_id|
    ConfidenceInterval.new(
      probability_of_success: @dataset.success_percent(group: group_id),
      observation_size: @dataset.groups[group_id].size,
      confidence_level: 0.95
    )
  end

  chi_square = ChiSquare.new(dataset: dataset)
  
  appview = AppView.new

  puts appview.dataset_message(dataset)
  puts appview.interval_table(intervals)
  puts appview.chisquare_results(chi_square)
end

main
