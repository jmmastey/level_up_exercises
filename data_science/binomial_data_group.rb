require_relative "binomialable"
class BinomialDataGroup
  attr_reader :id
  include Binomialable

  def initialize(params)
    @data = params[:data]
    @result_field = params[:result_field]
    @id = params[:id]
  end

  def confidence_interval
    ConfidenceInterval.new(
      success_count: success_count,
      fail_count: fail_count,
      confidence_level: 0.95
    )
  end

  def to_s
    format("(total '#{@data.size}', successes '#{success_count}', " \
    "failures '#{fail_count}', percent success '%4f%%')", 100*success_percent)
  end
end
