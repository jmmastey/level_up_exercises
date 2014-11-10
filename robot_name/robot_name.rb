class NameCollisionError < RuntimeError; end

class Robot
  attr_accessor :name

  GENERATE_CHAR = -> { ('A'..'Z').to_a.sample }
  GENERATE_NAME = "#{GENERATE_CHAR.call}#{GENERATE_CHAR.call}#{rand(10)}#{ rand(10) }#{rand(10)}"

  def initialize(args = {})
    @@registry ||= []
    @user_generator = args[:name_generator]
    set_name
    check_for_name_error
    append_name_to_registry
  end

  def set_name
    if @user_generator
      @name = @user_generator.call
    else
      @name = GENERATE_NAME
    end
  end

  def check_for_name_error
    raise NameCollisionError, 'There was a problem generating the robot name!' if bad_name?
  end

  def bad_name?
    !(@name =~ /[[:alpha:]]{2}[[:digit:]]{3}/) || @@registry.include?(@name)
  end

  def append_name_to_registry
    @@registry << @name
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
# generator = -> { 'AA111' }
# Robot.new(name_generator: generator)
# Robot.new(name_generator: generator)
