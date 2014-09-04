class NameCollisionError < RuntimeError; end;

class Robot
  attr_accessor :name
  attr_reader :name_generator

  @@registry

  def initialize(args = {})
    @@registry ||= []
    @name_generator = args[:name_generator]
    if @name_generator
      @name = @name_generator.call
    else
      @name = generate_name
    end
    validate_name
    @@registry << @name
  end

  def validate_name
    if !(self.name =~ /[[:alpha:]]{2}[[:digit:]]{3}/) || @@registry.include?(self.name)
      raise NameCollisionError, 'There was a problem generating the robot name!'
    end
  end

  def generate_name
    generated_name = ''
    5.times do |num|
      generated_name += "#{generator(num).call}"
    end
    generated_name
  end

  def generator(n)
    if n < 2
    generate_char = -> { ('A'..'Z').to_a.sample }
    generate_char
    else
      generate_num = -> { rand(10) }
      generate_num
    end
  end

end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
generator = -> { 'AA111' }
Robot.new(name_generator: generator)
# Robot.new(name_generator: generator)
