class RegistryError < RuntimeError
  def initialize(message = nil)
    message ||= "Valid registry was not provided"
    super
  end
end
