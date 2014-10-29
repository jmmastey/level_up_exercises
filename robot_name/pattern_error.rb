class PatternError < RuntimeError
  def initialize(msg=nil)
    @message = msg
  end

  def message
    @message || "Generated robot name does not conform to the accepted pattern"
  end
end
