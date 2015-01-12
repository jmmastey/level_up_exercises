require 'json'
require 'abanalyzer'

class ABDataSummary
  attr_reader :json_length, :a_conv, :a_nonconv, :b_conv, :b_nonconv, :results

  def initialize(json)
    @results = parse_and_sum(json)
    @a_conv = @results[:a_1] || 0
    @a_nonconv = @results[:a_0] || 0
    @b_conv = @results[:b_1] || 0
    @b_nonconv = @results[:b_0] || 0
    validate_data
  end

  private

  def parse_and_sum(json)
    data = JSON.parse(File.read(json), symbolize_names: true)
    @json_length = data.length
    raise "Not enough data points" unless @json_length > 1
    data = data.group_by { |h| [h[:cohort].downcase.to_sym, h[:result]] }
    data = data.map { |k, v| [k.join("_").to_sym, v.length] }.to_h
  end

  def validate_data
    sum = @a_conv + @a_nonconv + @b_conv + @b_nonconv
    raise "Extraneous data" unless sum == @json_length
   end
end
