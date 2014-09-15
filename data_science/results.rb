require "json"

class Results
  attr_reader :filename, :cohorts

  def initialize
    @cohorts = []
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
      cohorts << Cohort.new(data["cohort"])
    end
  end
end

