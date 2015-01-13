require 'json'
require 'abanalyzer'

class ABDataSummary
  VALID_RESULTS = [:a_0, :a_1, :b_0, :b_1]

  attr_reader :a_conv, :a_nonconv, :b_conv, :b_nonconv

  def initialize(json)
    results = tally_data(parse_json(json))
    @a_conv = results[:a_1]
    @a_nonconv = results[:a_0]
    @b_conv = results[:b_1]
    @b_nonconv = results[:b_0]
  end

  private

  def tally_data(data)
    results = Hash.new { |h, k| h[k] = 0 }
    data.each do |item|
      results[(item[:cohort].downcase + "_" + item[:result].to_s).to_sym] += 1
    end
    validate_results(results)
    results
  end

  def validate_results(results)
    raise ArgumentError unless (results.keys - VALID_RESULTS).empty?
    raise ArgumentError, "No A data" unless results[:a_0] + results[:a_1] > 0
    raise ArgumentError, "No B data" unless results[:b_0] + results[:b_1] > 0
  end

  def parse_json(json)
    JSON.parse(File.read(json), symbolize_names: true)
  end
end
