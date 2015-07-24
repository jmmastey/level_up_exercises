class Visit
  attr_accessor :result, :date

  def initialize(result, date)
    @result = result
    @date = date
  end

  def conversion?
    result == 1
  end
end
