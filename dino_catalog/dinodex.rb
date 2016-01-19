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
  banner <<-EOS
Dinodex allows you to pass in a hash using a yaml file using --search_file
 - The Yaml file should contain the search category in symbol form,
followed by the value you wish. You can also chain your searches in the Yaml.

A line the yaml file would look like this...   :walking: "Biped"

Use search categories :weight_greater_than and :weight_less_than for weight
ranges.

 - Output is always printed to the screen. You can choose a path for a
 file that outputs your answers to json using --output_file

- Usage:
      dinodex.rb [options]
where [options] are:
EOS
  opt :search_file, "Path of the search YAML file", type: String
  opt :output_file, "Path of the file for JSON output", type: String
end
Trollop.die :search_file, "must exist" unless command_opts[:search_file]

# Import the data and search
search_hash = UserOptions.create_hash_from_yaml(command_opts[:search_file])
filtered_dinos = DinoFilter.search(DinoCollection.new(true), search_hash)
filtered_dinos.fancy_display

# Output to file if specified
if command_opts[:output_file]
  File.open(command_opts[:output_file], "w") do |f|
    f.write(JSON.pretty_generate(filtered_dinos.create_hash_from_dinos))
  end
  puts
  puts "Your search results can be found in file: #{command_opts[:output_file]}"
end
