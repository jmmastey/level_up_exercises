class NameCollisionError < RuntimeError; end

class Robot
  attr_accessor :name

  @@registry

  def initialize(args = {})
    @name = ""
    @@registry ||= []
    @name_generator = args[:name_generator]

    generate_name()
  end

  def create_name
    if @name_generator
      @name = @name_generator.call
    else
      generate_char = -> { ('A'..'Z').to_a.sample }
      generate_num = -> { rand(10) }
      5.times { |pos| 
        @name << ( pos < 2 ? generate_char.call : generate_num.call.to_s ) 
      }
    end
  end

  def validate_name()
    valid_name = /[[:alpha:]]{2}[[:digit:]]{3}/
    if !(@name =~ valid_name) || @@registry.include?(@name)
      raise NameCollisionError, 'There was a problem generating the robot name!'
    end
  end

  def generate_name
    create_name()
    validate_name()
    @@registry << @name
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
# generator = -> { 'AA111' }
# Robot.new(name_generator: generator)
# Robot.new(name_generator: generator)
