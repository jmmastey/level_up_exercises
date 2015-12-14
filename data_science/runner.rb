require "./data_science"
require "./json_io"

data = JsonIO.new("./data_export_2014_06_20_15_59_02.json").read
app = DataScience.new(data)
puts app.sample_size
puts app.conversions
puts app.confidence
puts app.significant?
puts "#{app.chi_square}"
