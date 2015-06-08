require 'json'

class LoadData
  attr_accessor :json_data

  def initialize(json_file)
    raise "This is an empty file" unless json_file
    json = File.read(json_file)
    @json_data =  JSON.parse(json)
  end

  def total_sample_size
    @json_data.size
  end
end