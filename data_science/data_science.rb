require_relative 'Data_loader'
require_relative 'sample'

class DataScience
  my_data = DataLoader.new
  my_data.read_in_json
  my_data.build_data
  group_a, group_b = my_data.seperate_groups

  values = {}

  sample_a = Sample.new(group_a, values)
  sample_b = Sample.new(group_b, values)

  confidence_a = sample_a.calc_values
  confidence_b = sample_b.calc_values

  sample_a.print(values[:A], confidence_a, "Group A")
  sample_b.print(values[:B], confidence_b, "Group B")

  Sample.determine_leader(values, [confidence_a[:high], confidence_b[:high]])
end
