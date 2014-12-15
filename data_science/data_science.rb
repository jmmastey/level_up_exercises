require_relative 'DataLoader.rb'
require_relative 'sample.rb'

class DataScience
  data_in = DataLoader.read_in_json(DataLoader.file_name)
  DataLoader.build_data(data_in)
  group_a, group_b = DataLoader.seperate_groups
  values = {}
  @confidence_a = Sample.calculate_values(group_a, :agroup, values)
  @confidence_b = Sample.calculate_values(group_b, :bgroup, values)
  Sample.print(values[:agroup], @confidence_a, "Group A")
  puts
  Sample.print(values[:bgroup], @confidence_b, "Group B")
  Sample.determine_leader(values, [@confidence_a[:high], @confidence_b[:high]])
end
