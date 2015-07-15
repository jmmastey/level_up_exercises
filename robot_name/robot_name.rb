class NameCollisionError < RuntimeError; end

class Robot
  attr_accessor :name

  def initialize(args = {})
    @@registry ||= []
    @name_generator = args[:name_generator]

    @name = @name_generator ? @name_generator.call : generate_name
    add_name_to_registry
  end

  def add_name_to_registry
    if valid_name?
      @@registry << @name
    else
      raise NameCollisionError, 'There was a problem generating the robot name!'
    end
  end

  def generate_name
    "#{rand_char}#{rand_char}#{rand_num}#{rand_num}#{rand_num}"
  end

  def rand_char
    ('A'..'Z').to_a.sample
  end

  def rand_num
    rand(10)
  end

  def valid_name?
    name_is_correct_format? && !name_in_registry?
  end

  def name_is_correct_format?
    !!(@name =~ /[[:alpha:]]{2}[[:digit:]]{3}/)
  end

  def name_in_registry?
    @@registry.include?(@name)
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
# generator = -> { 'AA111' }
# Robot.new(name_generator: generator)
# Robot.new(name_generator: generator)
