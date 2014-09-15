require_relative "./viewparser"

def main
  data_path = "source_data.json"
  data = ViewParser.new.parse(data_path)
  data_set = DataSet.new(
    group_field: id, control_id: "A",
    result_field: :purchased, data: data
  )
end

main
