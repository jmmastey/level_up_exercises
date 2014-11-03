class NameCollisionError < RuntimeError
  def initialize(message = nil)
    message ||= "Generated name already exists in the registry"
    super
  end
end
