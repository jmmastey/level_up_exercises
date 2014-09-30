require_relative "binomial"
class BinomialDataGroup
  attr_reader :id
  include Binomial

  def initialize(data: nil, result_field: nil, id: nil)
    @data = data
    @result_field = result_field
    @id = id
  end

  def to_s
    format("(total '#{@data.size}', successes '#{success_count}', " \
    "failures '#{fail_count}', percent success '%4f%%')", 100 * success_percent)
  end
end
