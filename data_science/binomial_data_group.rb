require_relative "binomial"
class BinomialDataGroup
  attr_reader :id
  include Binomial

  def initialize(args)
    @data = args[:data]
    @result_field = args[:result_field]
    @id = args[:id]
  end

  def to_s
    base_string = "(total '#{@data.size}', successes '#{success_count}', " \
    "failures '#{fail_count}', percent success '%4f%%')"
    format(base_string, 100 * success_percent)
  end
end
