require 'json'
require 'pry'
# This class handles the json data.
class DataLoader
  attr_accessor :json_data

  def initialize(json_filename)
    raise 'You did not enter a file name' if json_filename.empty?
    json = File.read(json_filename)
    @json_data =  JSON.parse(json)
  end

  def total_sample_size
    @json_data.size
  end
end
