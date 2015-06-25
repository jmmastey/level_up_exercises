class NameCollisionError < RuntimeError; end

class Robot
  attr_accessor :name

  @@registry

  def name_generator(args)
    @name_generator = args[:name_generator]
    @name = @name_generator.call if @name_generator
  end

  def random_name_generator
    generate_char = -> { ('A'..'Z').to_a.sample }
    generate_num = -> { rand(10) }

    alpha = "#{generate_char.call}#{generate_char.call}"
    numeric = "#{generate_num.call}#{generate_num.call}#{generate_num.call}"
    @name = alpha + numeric
  end

  def validate_generated_name
    raise NameCollisionError, 'There was a problem generating the robot name!' if !(name =~ /[[:alpha:]]{2}[[:digit:]]{3}/) || @@registry.include?(name)
  end

  def initialize(args = {})
    @@registry ||= []

    name_generator(args)
    random_name_generator if !@name_generator
    validate_generated_name

    @@registry << @name
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
generator = -> { 'AA111' }
Robot.new(name_generator: generator)
Robot.new(name_generator: generator)
