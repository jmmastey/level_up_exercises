require_relative 'name_generator'
require_relative 'Robot'

class NameCollisionError < RuntimeError; end
class RobotFactory
  def initialize
    @registry ||= []
    @name_generator = NameGenerator.new
  end

  def create_robot(name = nil)
    if name
      raise_exception unless valid_name?(name)
    else
      name = generate_name
    end
    @registry << name
    Robot.new(name)
  end

  private

  def generate_name
    name = @name_generator.new_name
    loop do
      break if valid_name?(name)
      name = @name_generator.new_name
    end
    name
  end

  def valid_format?(name)
    (name =~ /[[:alpha:]]{2}[[:digit:]]{3}/)
  end

  def valid_name?(name)
    (valid_format?(name) && !@registry.include?(name))
  end

  def raise_exception
    raise NameCollisionError, 'There was a problem generating the robot'
  end
end
