class Traffic
  attr_reader :date, :cohort, :result

  def initialize(options = {})
    @date   = options[:date]
    @cohort = options[:cohort]
    @result = options[:result]
  end

  def to_s
    "#{@date} #{@cohort} #{@result}"
  end
end
