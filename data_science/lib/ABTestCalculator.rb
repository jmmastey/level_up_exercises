require "JSON"

class ABTestCalculator
  attr_accessor :data

  def initialize(attrs = {})
    read_data(attrs[:json_file])
  end

  def read_data(json_file)
    File.open(json_file, "r") do |f|
      @data = JSON.parse(f.read)
    end
  end
end
