class BinomialDataGroup
  attr_reader :id

  def initialize(params)
    @data = params[:data]
    @result_field = params[:result_field]
    @id = params[:id]
  end

  def fail_percent
    fail_count.to_f / @data.size
  end

  def success_percent
    success_count.to_f / @data.size
  end

  def success_count
    @data.count(&@result_field)
  end

  def fail_count
    @data.size - success_count
  end

  def count
    @data.size
  end

  def to_s
    "total '#{@data.size}', successes '#{success_count}', " \
    "failures '#{fail_count}', percent success '#{success_percent}'"
  end
end
