class NameCollisionError < RuntimeError; end

class Robot
  attr_accessor :name

  @@registry

  def initialize(args = {})
    @@registry ||= []
    
   # if args[:name_generator]

    
    @name_generator = args[:name_generator]

    if @name_generator
      @name = @name_generator.call
    else
     @name = generate_name
    end

    raise NameCollisionError, 'There was a problem generating the robot name!' if !(name =~ /[[:alpha:]]{2}[[:digit:]]{3}/) || @@registry.include?(name)
    @@registry << @name
  end
end

  def set_name(name)
  
  end

  def generate_name
    generate_char = -> { ('A'..'Z').to_a.sample }
    "#{generate_char.call}#{generate_char.call}#{rand(10)}#{rand(10)}#{rand(10)}"
  end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
# generator = -> { 'AA111' }
# Robot.new(name_generator: generator)
# Robot.new(name_generator: generator)
