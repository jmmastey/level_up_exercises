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

  chisquare = ChiSquare.new(dataset: dataset)
end

main
