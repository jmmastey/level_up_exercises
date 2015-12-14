class DataLoader
  def self.load_data(filename_or_array)
    return parse(filename_or_array) if filename_or_array.class == Array
    parse(load_json(filename_or_array))
  end

  def self.load_json(json_data_filename)
    data = File.open(json_data_filename, "r", &:read)
    JSON.parse(data)
  end

  def self.parse(data)
    result = Hash.new do |hash, key|
      hash[key] = { successes: 0, failures: 0 }
    end
    data.each_with_object(result) do |entry, res|
      result_key = key_or_sym(entry, "result") == 1 ? :successes : :failures
      res[key_or_sym(entry, "cohort").to_sym][result_key] += 1
    end
  end

  def self.key_or_sym(hash, value)
    hash[value.to_sym] || hash[value.to_s]
  end
end
