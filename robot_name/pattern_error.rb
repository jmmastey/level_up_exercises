class PatternError < RuntimeError
  def initialize(msg = nil)
    @message = msg || "Robot name does not match the pattern"
  end

  def message
    @message
  end
end
