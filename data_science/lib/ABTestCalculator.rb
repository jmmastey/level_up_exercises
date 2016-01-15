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

  def total_sample_size
    0
  end

  def total_conversions
    0
  end

  def conversion_rate
    0.0
  end
end
