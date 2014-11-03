class RobotNameFactoryError < RuntimeError
  def initialize(msg = nil)
    @message= msg || "Provided robot name factory is not valid"
  end

  def message
    @message
  end
end
