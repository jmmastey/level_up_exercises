require 'json'

class FileNotFoundError < StandardError; end
class InvalidFileTypeError  < StandardError; end

# The generate A\B Test json format data parser
# Due to this reason the variable name is based on generic name
# instead of using the name on data science
class ABDataParser
  def initialize
    @ab_test_data = {}
  end

  def parse_data(args = {})
    fail ArgumentError, 'Argument cannot be empty' if args.empty?
    fail ArgumentError, 'Wrong file type' unless valid_json_argument?(args)
    fail InvalidFileTypeError unless valid_file_type?(args[:file_name])
    fail FileNotFoundError unless File.exist?(args[:file_name])
    json_obj = File.read(args[:file_name])
    JSON.parse(json_obj).each { |record| populate_data(record) }
    @ab_test_data
  end

  private

  def valid_file_type?(file_name)
    File.extname(file_name) == '.json'
  end

  def valid_json_argument?(json_obj)
    matchs = (json_obj.keys & [:file_name, :variant_key, :result_key])
    @variant_key = json_obj[:variant_key]
    @result_key = json_obj[:result_key]
    matchs.length == 3
  end

  def populate_data(record)
    variant_data = record[@variant_key].to_sym
    @ab_test_data[variant_data] ||= { total_samples: 0, conversions: 0 }
    @ab_test_data[variant_data][:total_samples] += 1
    @ab_test_data[variant_data][:conversions] += record[@result_key].to_i
  end
end
