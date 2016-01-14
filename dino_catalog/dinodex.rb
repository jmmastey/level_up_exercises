require "./dino_data"
require "./filter_dinos"
require "./import"
require 'trollop'
require 'yaml'
require 'json'
require 'csv'

class UserOptions
  def self.create_hash_from_yaml(file_path)
    YAML.load_file(file_path)
  end
end

# Command line options
command_opts = Trollop.options do
  opt :search_file, "Path of the search YAML file", type: String
  opt :json_output, "Path of the file for JSON output", type: String
end
Trollop.die :search_file, "must exist" unless command_opts[:search_file]

# Import the data and search
search_hash = UserOptions.create_hash_from_yaml(command_opts[:search_file])
filtered_dinos = DinoFilter.search(DinoCollection.new(true), search_hash)
filtered_dinos.fancy_display

# Output to file if specified
if command_opts[:json_output]
  File.open(command_opts[:json_output], "w") do |f|
    f.write(JSON.pretty_generate(filtered_dinos.create_hash_from_dinos))
  end
  puts
  puts "Your search results can be found in file: #{command_opts[:json_output]}"
end
