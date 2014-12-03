class NameCollisionError < RuntimeError; end
class DuplicateNameError < RuntimeError; end

class Robot
  attr_accessor :name

  @@registry = ["DT447"]

  def initialize(args = {})
    @@registry ||= []
    @name = args[:name_generator]

    @name = create_name unless @name
    invalid_format?(@name) || registry_duplicate?(@name)

    @@registry << @name
  end

  private

  def invalid_format?(name)
    raise NameCollisionError unless name =~ /[[:alpha:]]{2}[[:digit:]]{3}/
  end

  def registry_duplicate?(name)
    raise DuplicateNameError if @@registry.include?(name)
  end

  def create_name
    name = ''
    2.times { name << generate_character }
    3.times { name << generate_number.to_s }
    name
  end

  def generate_character
    ('A'..'Z').to_a.sample
  end

  def generate_number
    rand(10)
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

robot = Robot.new(name_generator: "DT447")
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
# generator = -> { 'AA111' }
# Robot.new(name_generator: generator)
# Robot.new(name_generator: generator)
