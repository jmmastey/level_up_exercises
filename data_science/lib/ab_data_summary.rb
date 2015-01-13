require 'json'
require 'abanalyzer'

class ABDataSummary
  attr_reader :a_conv, :a_nonconv, :b_conv, :b_nonconv

  def initialize(json)
    results = parse_and_sum(parse_json(json))
    #p results
    @a_conv = results[:a_1] || 0
    @a_nonconv = results[:a_0] || 0
    @b_conv = results[:b_1] || 0
    @b_nonconv = results[:b_0] || 0
    validate_data
  end

  private

  def parse_and_sum(data)
    # raise "Not enough data points" unless @json_length > 1
    @json_length = data.length
    data.each_with_object({a_1: 0, a_0: 0, b_1: 0, b_0: 0}) do |(k,v), results|
      if k[:cohort] == "A"
        if k[:result] == 1
          results[:a_1] += 1
        else
          results[:a_0] += 1
        end
      elsif k[:cohort] == "B"
        if k[:result] == 1
          results[:b_1] += 1
        else
          results[:b_0] += 1
        end
      end
    end
    # raise "Extraneous data" unless data.length == 
  end

  def parse_json(json)
    JSON.parse(File.read(json), symbolize_names: true)
  end

  def validate_data
    raise "Insufficient data for cohort A" unless @a_conv + @a_nonconv > 0
    raise "Insufficient data for cohort B" unless @b_conv + @b_nonconv > 0
    sum = @a_conv + @a_nonconv + @b_conv + @b_nonconv
    #puts @a_conv + @a_nonconv + @b_conv + @b_nonconv
    #puts sum
    raise "Extraneous data" unless sum == @json_length
   end
end
