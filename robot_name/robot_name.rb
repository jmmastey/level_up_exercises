class NameCollisionError < RuntimeError; end

class Robot
  attr_accessor :name
  CHARS = 2
  NUMS = 3
  @@registry

  def initialize(args = {})
    @@registry ||= []
    @name_generator = args[:name_generator]
    generate_name
    add_name_to_registry
  end

  def registry
    @@registry
  end

  private

  def generate_name
    if @name_generator
      self.name = @name_generator.call
    else
      generator
    end
  end

  def generator
    self.name = ""
    add_chars
    add_nums
  end

  def add_chars
    (1..CHARS).each { name << generate_char }
  end

  def add_nums
    (1..NUMS).each { name << generate_num.to_s }
  end

  def generate_char
    ('A'..'Z').to_a.sample
  end

  def generate_num
    rand(10)
  end

  def add_name_to_registry
    if name_invalid_format? || name_is_duplicate?
      raise NameCollisionError, 'There was a problem generating the robot name!'
    else
      @@registry << name
    end
  end

  def name_invalid_format?
    !(name =~ /[[:alpha:]]{2}[[:digit:]]{3}/)
  end

  def name_is_duplicate?
    @@registry.include?(name)
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."
robot2 = Robot.new
robot3 = Robot.new
puts robot3.registry

# # Errors!
# generator = -> { 'AA111' }
# robot2 = Robot.new(name_generator: generator)
# robot3 = Robot.new(name_generator: generator)
# puts robot3.registry