class DuplicateNameError < RuntimeError; end
class InvalidNameError < RuntimeError; end

class Registry
  @robot_names = []

  def self.add_name(name)
    check_for_duplicate(name)
    @robot_names << name
  end

  def self.check_for_duplicate(name)
    if @robot_names.include?(name)
      raise DuplicateNameError, 'Robot name already exists!'
    end
  end

  private_class_method :check_for_duplicate
end

class Robot
  attr_accessor :name

  def initialize(generator = nil)
    @name = generate_name(generator)
    validate_name
    Registry.add_name(@name)
  end

  private

  def generate_name(generator)
    return generator.call if generator

    chars = 2.times.map { generate_char }
    digits = 3.times.map { generate_digit }
    (chars + digits).inject("") { |name, char| name << char }
  end

  def validate_name
    is_invalid = !(name =~ /[[:alpha:]]{2}[[:digit:]]{3}/)
    raise InvalidNameError, "#{name} is invalid" if is_invalid
  end

  def generate_char
    ('A'..'Z').to_a.sample
  end

  def generate_digit
    rand(10).to_s
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
# generator = -> { 'AA111' }
# Robot.new(generator)
# Robot.new(generator)

# generator = -> { 'AA11' }
# Robot.new(generator)
