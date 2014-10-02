class NameCollisionError < RuntimeError; end

class Robot
  attr_accessor :name
  @@registry ||= []

  def initialize(args = {})
    @name_generator = args[:name_generator]
    @name = fetch_name

    @@registry << @name if valid_name? && !name_in_registry?
  end

  def fetch_name
    if @name_generator
      @name = @name_generator.call
    else
      @name = generate_new_name
    end
  end

  def generate_new_name
    generate_char.to_s +
    generate_char.to_s +
    generate_num.to_s +
    generate_num.to_s +
    generate_num.to_s
  end

  def generate_char
    ('A'..'Z').to_a.sample
  end

  def generate_num
    rand(10)
  end

  def valid_name?
    return true if name =~ /[[:alpha:]]{2}[[:digit:]]{3}/

    raise NameCollisionError, "There was a problem generating the robot name!"
  end

  def name_in_registry?
    return false unless @@registry.include? name

    raise NameCollisionError, "This name already exists for a robot"
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
generator = -> { 'AA111' }
Robot.new(name_generator: generator)
Robot.new(name_generator: generator)
