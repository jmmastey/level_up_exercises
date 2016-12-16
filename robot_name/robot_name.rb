class Robot
  NameCollisionError = Class.new(RuntimeError)

  NAME_ERROR_MSG = 'There was a problem generating the robot name!'.freeze

  attr_reader :name

  class << self
    attr_accessor :registry
  end
  @registry ||= []

  def initialize(args = {})
    name_generator = args.fetch(:name_generator, false)
    @name = name_generator ? name_generator.call : generate_new_name
    raise NameCollisionError, NAME_ERROR_MSG if invalid_name?
    Robot.registry << @name
  end

  private

  def generate_new_name
    generate_char = -> { ('A'..'Z').to_a.sample }
    generate_num = -> { rand(10) }

    [Array.new(2) { generate_char.call },
     Array.new(3) { generate_num.call }].join
  end

  def invalid_name?
    !(name =~ /[[:alpha:]]{2}[[:digit:]]{3}/) || Robot.registry.include?(name)
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
generator = -> { 'AA111' }
Robot.new(name_generator: generator)
Robot.new(name_generator: generator)
