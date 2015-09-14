require "json"
require_relative "errors"

class FileParser
  ERROR_FILE_MISSING = "File does not exist, or was not specified."

  def self.parse_data(filepath)
    raise MissingFileError, ERROR_FILE_MISSING unless File.exist?(filepath)
    json_data = JSON.parse(File.read(filepath))
    json_hash = {}
    json_data.each do |data_line|
      json_hash[data_line['cohort']] ||= []
      json_hash[data_line['cohort']] << data_line['result']
    end
    json_hash
  end
end
