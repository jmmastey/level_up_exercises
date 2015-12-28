require 'pry'
class NameCollisionError < RuntimeError; 
  def self.message()
    'There was a problem generating the robot name!'
  end
end

class Robot
  attr_accessor :name

  @@registry

  def initialize(args = {})
    @name = ''
    @@registry ||= []
    @name_generator = args[:name_generator]
    generate_name
    @@registry << @name
  end

  def generate_name
    @name = @name_generator.call if @name_generator
    default_name_generator if @name.empty?
    if !(name =~ /[[:alpha:]]{2}[[:digit:]]{3}/) || @@registry.include?(name)
      raise NameCollisionError, NameCollisionError.message 
    end
  end
  
  def default_name_generator
    generate_char = -> { ('A'..'Z').to_a.sample }
    generate_num = -> { rand(10) }
    @name = "#{generate_char.call}#{generate_char.call}"\
      + "#{generate_num.call}#{generate_num.call}#{generate_num.call}"
  end
end
 

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
=begin
generator = -> { 'AA111' }
robot = Robot.new(name_generator: generator)
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."
Robot.new(name_generator: generator)
=end
