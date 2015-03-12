class NameCreateError < RuntimeError; end
class NameInvalidError < RuntimeError; end

class Robot
  attr_reader :name

  ERR_INVALID = 'Invalid robot name generated!'
  ERR_CREATE  = 'Could not create a unique robot name!'
  MAX_RETRIES = 10

  def initialize(generator = nil)
    @@registry ||= []

    @name = generate_unique_name(generator, MAX_RETRIES)

    @@registry << @name
  end

  def generate_unique_name(generator, retries)
    (1..retries).each do
      new_name = generator ? generator.call : generate_name
      return new_name if unique?(new_name) && valid?(new_name)
    end

    raise NameCreateError, ERR_CREATE
  end

  def generate_name
    "#{generate_char_str(2)}#{generate_num_str(3)}"
  end

  def unique?(name)
    @@registry.include?(name) ? false : true
  end

  def valid?(name)
    valid = name.match(/[[:alpha:]]{2}[[:digit:]]{3}/)
    raise NameInvalidError, ERR_INVALID unless valid
    valid
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
