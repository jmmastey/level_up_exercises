class PatternError < RuntimeError
  def initialize(msg=nil)
    @message = msg
  end

  def message
    @message || default_message
  end

  def default_message
    "Generated robot name does not conform to the accepted pattern"
  end

  private :default_message
end
