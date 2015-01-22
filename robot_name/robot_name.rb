require './name_generator.rb'
require './check_registry.rb'

class NameCollisionError < RuntimeError; end

class Robot
  attr_accessor :name

  @@registry

#  def initialize(name = NameGenerator)
#    @@registry ||= []
#    @name_generator = args[:name_generator]
#
#    if @name_generator
#      @name = @name_generator.call
#    else
#      generate_char = -> { ('A'..'Z').to_a.sample }
#      generate_num = -> { rand(10) }
#      @name = "#{generate_char.call}#{generate_char.call}#{generate_num.call}#{generate_num.call}#{generate_num.call}"
#    end
#
#    raise NameCollisionError, 'There was a problem generating the robot name!' if !(name =~ /[[:alpha:]]{2}[[:digit:]]{3}/) || @@registry.include?(name)
#    @@registry << @name
#  end

  def initialize(name_generator = NameGenerator)
    @@registry ||= []
    @name = name_generator.call
    raise NameCollisionError, "The name generated '#{@name}' already exists in the registry!" if CheckRegistry.name_exists?(@@registry, @name)
    @@registry << @name
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
# generator = -> { 'AA111' }
# Robot.new(name_generator: generator)
# Robot.new(name_generator: generator)
