require 'json'
require_relative 'experiment.rb'

class Parser
  attr_reader :filepath

  def self.parse(filepath)
    JSON.parse(File.read(filepath))
  end

end

Experiment.new(Parser.parse('source_data.json')).report