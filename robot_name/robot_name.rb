# Trying to undestand the code:
  # - There is a Robot class that uses a class variable to keep track of an array of names
  #   that are given to its intances during runtime.
  # - Each instance has a name that is randomly generated in the initialize method.






class NameCollisionError < RuntimeError; end

class Robot
  attr_accessor :name
  attr_reader :registry

  def initialize(args = {})
    @@registry ||= []
    @name_generator = args[:name_generator]

    # If a name generator is passed in, use it and set it to @name
    if @name_generator
      @name = @name_generator.call # this calls the block that is passed in
    else
      @@registry << generate_name
    end

    raise_validation_message unless valid_name(@name)

  end

  def generate_name
    generate_char = -> { ('A'..'Z').to_a.sample }
    generate_num = -> { rand(10) }

    @name = "#{generate_char.call}#{generate_char.call}#{generate_num.call}#{generate_num.call}#{generate_num.call}"
  end

  def valid_name(name)
    return name =~ /[[:alpha:]]{2}[[:digit:]]{3}/ || @@registry.include?(name)
  end

  def raise_validation_message
    raise NameCollisionError, 'There was a problem generating the robot name!'
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."
robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
# generator = -> { 'AA111' }
# Robot.new(name_generator: generator)
# Robot.new(name_generator: generator)
