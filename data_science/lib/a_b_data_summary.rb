require 'json'
require 'abanalyzer'

class ABDataSummary
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
    results = { a_1: 0, a_0: 0, b_1: 0, b_0: 0 }
    data.each do |item|
      results[(item[:cohort].downcase + "_" + item[:result].to_s).to_sym] += 1
    end
    validate_data(data.length, results.values.inject(:+), results)
    results
  end

  def validate_data(data_length, total_trials, results)
    raise "Extraneous data" unless data_length == total_trials
    raise "Insufficient data for A" unless results[:a_0] + results[:a_1] > 0
    raise "Insufficient data for B" unless results[:b_0] + results[:b_1] > 0
  end

  def parse_json(json)
    JSON.parse(File.read(json), symbolize_names: true)
  end
end
