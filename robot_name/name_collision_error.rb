class NameCollisionError < RuntimeError
  def initialize(msg = nil)
    @message = msg || "Robot name already taken"
  end

  def message
    @message
  end
end
