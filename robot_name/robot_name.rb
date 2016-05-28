class NameCollisionError < RuntimeError
  def initialize(msg='There was a problem generating the robot name!')
    super
  end
end

class Robot
  attr_accessor :name

  @@registry

  def initialize(args = {})
    @@registry ||= []
    @name_generator = args[:name_generator] || method(:name_constructor)
    @name = @name_generator.call
    register_name
  end

  def register_name
    raise NameCollisionError if bad_name?
    @@registry << @name
  end

  def name_constructor
    generate_char = ('A'..'Z').to_a.sample(2)
    generate_num = (1..10).to_a.sample(3)
    @name = generate_char.concat(generate_num).join
  end

  def bad_name?
    (name =~ /[[:alpha:]]{2}[[:digit:]]{3}/) || @@registry.include?(name)
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."
generator = -> { 'POOP' }
# generator = -> { 'AA111' }
robot2 = Robot.new({name_generator: generator})
puts "My pet robot's name is #{robot2.name}, but we usually call him sparky."

# Errors!
# Robot.new(name_generator: generator)
# Robot.new(name_generator: generator)
