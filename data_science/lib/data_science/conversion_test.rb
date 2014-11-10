require 'json'

class ConversionTest
  attr_reader :name, :sample

  def initialize(name)
    @name = name
    @sample = Sample.new
  end

  def import_json_data(json_data)
    @sample.add_data_to_sample(json_data)
  end
end
