class NameCollisionError < RuntimeError; end
class NameInvalidError < RuntimeError; end

class Robot
  attr_reader :name

  ERR_INVALID   = 'An invalid robot name was generated!'
  ERR_COLLISION = 'A duplicate robot name was generated!'

  def initialize(generator = nil)
    @@registry ||= []
    @name_generator = generator

    @name = @name_generator ? @name_generator.call : generate_name
    check_name

    @@registry << @name
  end

  def check_name
    raise NameInvalidError, ERR_INVALID unless valid?(name)
    raise NameCollisionError, ERR_COLLISION if @@registry.include?(name)
  end

  def valid?(name)
    name.match(/[[:alpha:]]{2}[[:digit:]]{3}/)
  end

  def generate_name
    "#{generate_char_str(2)}#{generate_num_str(3)}"
  end

  def generate_char_str(length)
    str = ""

    length.times do
      str << ('A'..'Z').to_a.sample
    end

    str
  end

  def generate_num_str(length)
    str = ""

    length.times do
      str << rand(10).to_s
    end

    str
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
generator = -> { 'AA111' }
Robot.new(generator)
Robot.new(generator)
# Robot.new(name_generator: generator)
# Robot.new(name_generator: generator)
