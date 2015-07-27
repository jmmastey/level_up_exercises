require_relative 'robot_name_registry'

class Robot
  attr_accessor :name

  def initialize(args = {})
    @name_generator = args[:name_generator]
    give_name
    add_name_to_registry
  end

  def generate_char
    ('A'..'Z').to_a.sample
  end

  def generate_num
    rand(10)
  end

  def generate_name
    name = ""
    2.times { name += generate_char }
    3.times { name += generate_num.to_s }
    name
  end

  def give_name
    @name = @name_generator ? @name_generator.call : generate_name
  end

  def add_name_to_registry
    RobotNameRegistry.add_name(@name)
  end
end