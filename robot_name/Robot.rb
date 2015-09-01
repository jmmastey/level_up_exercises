require_relative "robot_registry"

class Robot
  attr_accessor :name

  def initialize(args = {})
    @name = call_name_generator(args[:name_generator]) || generate_robot_name
  end

  private

  def call_name_generator(name_generator)
    return false if name_generator.nil?
    name_generator.call
  end

  def generate_robot_name
    generate_char(2).concat(generate_num(3))
  end

  def generate_char(length = 1)
    length.times.map { [*'A'..'Z'].sample }.join("")
  end

  def generate_num(length = 1)
    length.times.map { rand(10) }.join("")
  end
end
