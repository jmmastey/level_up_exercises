require "json"
require_relative "errors"

class DataAnalyzer
  attr_accessor :filepath, :json_data

  ERROR_FILE_MISSING = "File does not exist, or was not specified."

  def initialize(filepath)
    raise MissingFileError, ERROR_FILE_MISSING unless File.exist?(filepath)
    @filepath   = filepath
    @json_data  = JSON.parse(File.read(filepath))
  end

  def parse_data
    json_hash = {}
    json_data.each do |data_line|
      json_hash[data_line['cohort']] ||= []
      json_hash[data_line['cohort']] << data_line['result']
    end
    json_hash
  end
end
