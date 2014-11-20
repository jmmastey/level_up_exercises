require 'json'
# ABDataParser Module
module ABDataParser
  def self.read(json_obj, varian_key, result_key)
    @ab_test_data = {}
    @variant_key, @result_key = varian_key, result_key
    parse_json_obj(json_obj)
    @ab_test_data
  end

  private

  def self.parse_json_obj(json_obj)
    json_obj = JSON.parse(json_obj)
    #groups = json_obj.group_by { |record| record[@variant_key.to_s] }.values
    groups = json_obj.partition{ |item| item[@variant_key] == 'A' }
    groups.each { |variant| populate_data(variant) }
    rescue JSON::ParserError
      raise "unable to parse the given json data"
  end

  def self.populate_data(data)
    variant_name = data.first[@variant_key.to_s].to_sym
    total_samples = data.length
    conversions = data.count { |row| row[@result_key.to_s] == 1 }
    @ab_test_data[variant_name] = { total_samples: total_samples,
                                    conversions: conversions }
  end
end
