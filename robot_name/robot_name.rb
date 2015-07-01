class RobotNameError < RuntimeError; end

class Robot
  class << self
    attr_accessor :registry
  end
  @registry = []

  attr_accessor :name

  def initialize(args = {})
    self.class.registry |= []
    @name_generator = args[:name_generator] || method(:create_name)
    assign_next_valid_name
    self.class.registry << @name
  end

  def create_name
    generate_char = -> { ('A'..'Z').to_a.sample }
    generate_digit = -> { rand(10).to_s }

    name = ""
    2.times { name << generate_char.call }
    3.times { name << generate_digit.call }
    name
  end

  def assign_next_valid_name
    @name = @name_generator.call
    @name = @name_generator.call if invalid_name?
    raise(RobotNameError, "Name already exists: #{@name}.") if duplicate_name?
    raise(RobotNameError, "Name has bad format: #{@name}.") if bad_format_name?
    name
  end

  def invalid_name?
    bad_format_name? || duplicate_name?
  end

  def bad_format_name?
    !(@name =~ /[[:alpha:]]{2}[[:digit:]]{3}/)
  end

  def duplicate_name?
    self.class.registry.include?(@name)
  end
end

robot = Robot.new
puts("My pet robot's name is #{robot.name}, but we usually call him sparky.")
