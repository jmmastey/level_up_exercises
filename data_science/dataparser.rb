require 'json'

class Dataparser
  attr_accessor :json_input, :data

  def initialize
    @json_input = []
    @data = {}
  end

  def load_json_file(file_name)
    @json_input = JSON.parse(IO.read(file_name))
    @json_input.each do |record|
      summarize record
    end
    @data
  end

  private

  def summarize(record_hash)
    variant = record_hash['cohort']
    @data[variant] ||= { total: 0.0, conversion: 0.0 }
    @data[variant][:total] += 1
    @data[variant][:conversion] += record_hash['result']
  end
end
