class NameCollisionError < RuntimeError; end

class Robot
  attr_accessor :name

  @registry ||= []

  def initialize(args = {})
    @name_generator = args[:name_generator]
    generate_name
    check_name_collision
    @registry << @name
  end

  def check_name_collision
    return unless invalid_generated_name
    raise NameCollisionError, 'There was a problem generating the robot name!'
  end

  def generate_name
    if @name_generator
      @name = @name_generator.call
    else
      @name = defualt_name_generator
    end
  end

  def defualt_name_generator
    generate_char = -> { ('A'..'Z').to_a.sample }
    generate_num = -> { rand(10) }
    "#{generate_char.call}#{generate_char.call}"\
    "#{generate_num.call}#{generate_num.call}#{generate_num.call}"
  end

  def invalid_generated_name
    !does_generated_name_follow_pattern || @registry.include?(name)
  end

  def does_generated_name_follow_pattern
    (name =~ /[[:alpha:]]{2}[[:digit:]]{3}/)
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
# generator = -> { 'AA111' }
# Robot.new(name_generator: generator)
# Robot.new(name_generator: generator)
