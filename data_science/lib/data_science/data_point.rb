class DataPoint
  attr_reader :date, :cohort, :result

  def initialize(args = {})
    @date = args["date"]
    @cohort = args["cohort"]
    @result = args["result"]
  end
end
