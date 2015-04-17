require 'csv'
require_relative './dino.rb'
require_relative './dino_filters.rb'
require_relative './data_reader.rb'
require_relative './user_input.rb'

# If you want to run your own queries, you just need
# to get the dino_filter_object

dino_filter = DataReader.new('dino_csv_list').dino_filter

user_input = UserInput.new
user_input.query_user

puts eval("dino_filter." + user_input.build_user_query)
