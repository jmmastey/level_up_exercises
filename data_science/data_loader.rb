class NotAJSONFileError < RuntimeError
  def message
    "Your file does not have a json extension"
  end
end

class FileDoesNotExistError < RuntimeError
  def message
    "Your file could not be found"
  end
end

require 'json'
class DataLoader
  def initialize(file_name = 'source_data.json')
    @file_name = file_name
  end

  def build_data
    @all_in = []
    @parsed.each do |row|
      date   = row['date']
      cohort = row['cohort']
      result = row['result']
      @all_in << Traffic.new(date: date, cohort: cohort, result: result)
    end
  end

  def seperate_groups
    @all_in.partition { |row| row.cohort.eql?('A') }
  end

  def read_in_json
    validate_file
    data_in = File.read(@file_name)
    @parsed = JSON.parse(data_in)
  end

  def validate_file
    errors_json = { NotAJSONFileError => @file_name.include?(".json"),
                    FileDoesNotExistError => File.exist?(@file_name) }

    errors_json.each do | error_name, function |
      raise error_name unless function
    end
  end
end
