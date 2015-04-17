require 'csv'
require_relative './dino.rb'
require_relative './dino_filters.rb'
require_relative './data_reader.rb'
require_relative './user_input.rb'

# This script reads the data and runs the queries of interest
# If you want to run your own queries, you can just need
# to get the dino_filter_object

data_reader = DataReader.new('dino_csv_list')
dino_filter = data_reader.dino_filter

user_input = UserInput.new

user_input.query_user
user_input.process_user_input
query = "dino_filter." + user_input.build_user_query

puts eval(query)

