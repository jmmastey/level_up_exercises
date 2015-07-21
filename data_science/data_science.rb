require_relative('json_parser')

class DataScience
  def load(filepath)
    @parser = JSONParser.new
    @data = @parser.parse(filepath)
  end

  def data_reader
    @data
  end

  def conversion_rate
    number_of_conversions.to_f / total_size.to_f
  end

  def total_size
    @data.length
  end

  def number_of_conversions
    conversions = 0
    @data.each do |entry|
      conversions += 1 if entry['result'] == 1
    end
    conversions
  end
end
