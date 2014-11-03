class RegistryError < RuntimeError
  def initialize(msg = nil)
    @message = msg
  end

  def message
    @message || "Valid robot name registry was not provided"
  end
end
