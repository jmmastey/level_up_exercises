NameCollisionError = Class.new(RuntimeError)

class RobotNameRegistry
  def initialize
    @registry = []
  end

  def push(name)
    validate(name)
    @registry << name
  end

  private

  def validate(name)
    error_message = "Generated name #{name} already exists in the registry"
    raise NameCollisionError, error_message if @registry.include?(name)
  end
end
