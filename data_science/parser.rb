require 'json'
require_relative 'experiment.rb'

class Parser
  def self.parse(filepath)
    JSON.parse(File.read(filepath))
  end

end

puts Experiment.new(Parser.parse('source_data.json')).report