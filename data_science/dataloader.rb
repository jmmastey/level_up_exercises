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
  def self.file_name
    'source_data.json'
  end

  def self.build_data(data_in)
    @all_in = []
    data_in.each do |row|
      date   = row['date']
      cohort = row['cohort']
      result = row['result']
      @all_in << Traffic.new(date: date, cohort: cohort, result: result)
    end
  end

  def self.seperate_groups
    @all_in.partition { |row| row.cohort.eql?('A') }
  end

  def self.read_in_json(json_file)
    validate_file(json_file)

    data_in = File.read(json_file)
    JSON.parse(data_in)
  end

  def self.validate_file(json_file)
    errors_json = { NotAJSONFileError => json_file.include?(".json"),
                    FileDoesNotExistError => File.exist?(json_file) }

    errors_json.each do | error_name, function |
      raise error_name unless function
    end
  end
end
