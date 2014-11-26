require 'json'

class DataParser
  attr_accessor :summary

  def initialize
    @summary = {}
  end

  def load_json_file(file_name)
    JSON.parse(IO.read(file_name)).each do |record|
      summarize(record)
    end
  end

  private

  def summarize(record_hash)
    variant = record_hash['cohort']
    @summary[variant] ||= { total: 0.0, conversion: 0.0 }
    @summary[variant][:total] += 1
    @summary[variant][:conversion] += record_hash['result']
  end
end
