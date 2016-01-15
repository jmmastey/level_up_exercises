require "JSON"

class ABTestCalculator
  attr_accessor :data

  def initialize(attrs = {})
    @json_file = attrs[:json_file]

    read_data
  end

  def read_data
    File.open(@json_file, "r") do |f|
      @data = JSON.parse(f.read)
    end
  end
end
