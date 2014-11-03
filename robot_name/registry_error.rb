class RegistryError < RuntimeError
  def initialize(msg = nil)
    @message= msg || "Valid robot name registry was not provided"
  end

  def message
    @message
  end
end
