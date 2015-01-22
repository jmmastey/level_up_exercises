require './name_generator.rb'
require './validate_name.rb'

class NameCollisionError < RuntimeError; end
class NameRegexError < RuntimeError; end

class Robot
  attr_accessor :name

  @@registry

  def initialize(options = {})
    @@registry ||= []
    name_generator = options[:name_generator] || NameGenerator
    @name = name_generator.call
    raise NameRegexError, "The name generated does not pass the Regex" unless ValidateName.match_regex?(@name)
    raise NameCollisionError, "The name '#{@name}' already exists in the registry!" if ValidateName.name_exists?(@@registry, @name)
    @@registry << @name
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

generator = -> { 'AA111' }
robot = Robot.new(name_generator: generator)
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

#THIS SHOULD ERROR
Robot.new(name_generator: generator)
