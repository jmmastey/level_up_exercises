require_relative "RobotRegistry"

class Robot
  
  attr_accessor :name

  def initialize(args = {})
    @name = (args[:name_generator] && args[:name_generator].call) || generate_robot_name
    RobotRegistry.add_robot_to_registry(name)
  end

  private

  def generate_robot_name
    "#{generate_char(2)}#{generate_num(3)}"
  end

  def generate_char(length=1)
    length.times.map { ('A'..'Z').to_a.sample }.join("")
  end

  def generate_num(length=1)
    length.times.map { rand(10) }.join("")
  end
end