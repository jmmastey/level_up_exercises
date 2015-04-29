require './data_reader.rb'
require './user_input.rb'

# If you want to run your own queries, you just need
# to get the dino_filter object.
dino_files = ["dinodex.csv", "african_dinosaur_export.csv"]

dino_filter = DataReader.new(dino_files).dino_filter

user_input = UserInput.new
user_input.query_user

dino_summary =  user_input.perform_user_query(dino_filter)

if dino_summary.length > 0
  puts dino_summary
else
  puts "No dinos remain after filtering."
end
