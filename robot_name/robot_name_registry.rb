InvalidNameError = Class.new(RuntimeError)
NameCollisionError = Class.new(RuntimeError)

class RobotNameRegistry
  VALID_NAME = /[[:alpha:]]{2}[[:digit:]]{3}/

  @names = []

  def self.add_name(name)
    raise InvalidNameError unless self.valid?(name)
    raise NameCollisionError unless self.unique?(name)
    @names << name
  end

  def self.valid?(name)
    name =~ VALID_NAME
  end

  def self.unique?(name)
    !@names.include?(name)
  end
end
