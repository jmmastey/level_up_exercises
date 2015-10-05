require 'pry'
class NameCollisionError < RuntimeError; end

ERROR = 'There was a problem generating the robot name!'

class Robot
  attr_accessor :name

  @@registry

  def initialize(name_generator = nil)
    @@registry ||= []
    @name = name_generator ? name_generator.call : generate_name
    duplication_check
  end

  def generate_name
      generate_char = -> { ('A'..'Z').to_a.sample }
      generate_num = -> { rand(10) }
      "#{generate_char.call}#{generate_char.call}#{generate_num.call}#{generate_num.call}#{generate_num.call}"
  end

  def duplication_check
    raise NameCollisionError, ERROR if incorrect_name_pattern? || name_taken?
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
robot1 = Robot.new(generator)
puts "My pet robot's name is #{robot1.name}, but we usually call him sparky."
robot1 = Robot.new(generator)
