require "json"

class Results
  attr_reader :filename, :data

  def initialize
    @data = []
  end

  def add_data(filename)
    @filename = filename
    parse_file
  end

  private

  def parse_file
    file = File.read filename
    input = JSON.parse file
    input.each do |data|
      @data << DataPoint.new(data["cohort"], data["result"])
    end
  end
end

