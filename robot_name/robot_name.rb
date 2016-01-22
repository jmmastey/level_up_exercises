class NameFormatError < RuntimeError; end
class NameCollisionError < RuntimeError; end

class Robot
  attr_accessor :name

  def name_generator
    @name_generator ||= -> { name_builder }
  end

  def initialize(args = {})
    @name_generator = args[:name_generator]
    @name = args[:name] ? register_name(args[:name]) : generate_name
  end

  private

  def self.registry
    @registry ||= []
  end

  def generate_name
    robot_name = name_generator.call

    register_name(robot_name)
  end

  def name_builder
    robot_name = "#{generate_char}#{generate_num_string}"

    return name_generator.call if name_exists?(robot_name)

    robot_name
  end

  def register_name(robot_name)
    raise NameCollisionError, "Robot name \"#{robot_name}\" "\
      "already exists!" if name_exists?(robot_name)

    raise NameFormatError, "Robot name \"#{robot_name}\" "\
      "is wrong format!" unless robot_name =~ /^[A-Z]{2}[0-9]{3}$/

    self.class.registry << robot_name

    robot_name
  end

  def generate_char
    ('A'..'Z').to_a.sample(2).join
  end

  def generate_num_string
    nums = ""
    (1..3).to_a.map { nums += rand(10).to_s }
    nums
  end

  def name_exists?(robot_name)
    self.class.registry.include?(robot_name)
  end
end
