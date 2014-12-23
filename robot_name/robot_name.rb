class NameInvalidError < RuntimeError; end
class NameDuplicateError < RuntimeError; end

class Robot
  attr_accessor :name
  CHARS = 2
  NUMS = 3
  @@registry = []

  def initialize(args = {})
    generate_name(args[:name_generator] || method(:random_name))
    add_name_to_registry
  end

  def registry
    @@registry
  end

  private

  def generate_name(generator)
    self.name = generator.call
  end

  def random_name
    (add_chars + add_nums).join
  end

  def add_chars
    (1..CHARS).map { generate_char }
  end

  def add_nums
    (1..NUMS).map { generate_num.to_s }
  end

  def generate_char
    ('A'..'Z').to_a.sample
  end

  def generate_num
    rand(10)
  end

  def add_name_to_registry
    if name_invalid_format?
      raise NameInvalidError, 'Your robot name is in an invalid format!'
    elsif name_is_duplicate?
      raise NameDuplicateError, 'Your robot name already exists in the registry!'
    else
      @@registry << name
    end
  end

  def name_invalid_format?
    !(name =~ /[[:alpha:]]{2}[[:digit:]]{3}/)
  end

  def name_is_duplicate?
    @@registry.include?(name)
  end
end


robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."
robot2 = Robot.new
robot3 = Robot.new
# puts robot3.registry

# Errors!
generator = -> { 'AA111' }
robot4 = Robot.new(name_generator: generator)
# robot5 = Robot.new(name_generator: generator)
puts robot4.registry