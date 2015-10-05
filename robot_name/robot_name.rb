require 'pry'
class NameCollisionError < RuntimeError; end

Error = 'There was a problem generating the robot name!'

class Robot
  attr_accessor :name
  @@registry
  def initialize(args = {})
    @@registry ||= []
    args[:name_generator].nil? ? generate_name : @name = args[:name_generator].call
    duplication_check
  end

  def generate_name
      generate_char = -> { ('A'..'Z').to_a.sample }
      generate_num = -> { rand(10) }
      @name = "#{generate_char.call}#{generate_char.call}#{generate_num.call}#{generate_num.call}#{generate_num.call}"
  end

  def duplication_check
    raise NameCollisionError, Error if incorrect_name_pattern? || name_taken?
    @@registry << @name
  end

  def name_taken?
    @@registry.include?(name)
  end

  def incorrect_name_pattern?
    !(name =~ /[[:alpha:]]{2}[[:digit:]]{3}/)
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

generator = -> { 'AA011' }
robot1 = Robot.new(name_generator: generator)
puts "My pet robot's name is #{robot1.name}, but we usually call him sparky."
robot = Robot.new(name_generator: generator)
