class NameCollisionError < RuntimeError; end;
class NameFormattingError < RuntimeError; end;

class Robot
  attr_accessor :name
  @error_msg = 'There was a problem generating the robot name!'
  @@registry

  def initialize(args = {})
    @@registry ||= []
    @name_generator = args[:name_generator]
    generate_name
    validate_name
    @@registry << @name
  end

  def Robot.count
    @@registry.count
  end

  private
  def generate_name
    if @name_generator
      @name = @name_generator.call
    else
      @name = random_name
    end
  end

  def random_name
    name = ""
    3.times { name += random_char  }
    2.times { name += random_digit.to_s }
    name
  end

  def random_char
    ('A'..'Z').to_a.sample
  end

  def random_digit
    rand(10)
  end

  def validate_name
    raise NameFormattingError, @error_msg unless correct_format?
    raise NameCollisionError, @error_msg if is_duplicate?
  end

  def correct_format?
    !(@name =~ /^[A-Z]{3}[0-9]{2}$/).nil?
  end

  def is_duplicate?
    @@registry.include?(@name)
  end

end

5.times do
  robot = Robot.new
  puts "Robot #{Robot.count}'s name is #{robot.name}, but we usually call him Sparky-#{Robot.count}."
end

generator = -> { 'ABC12' }
robot = Robot.new(name_generator: generator)
puts "Robot #{Robot.count}'s name is #{robot.name}, but we usually call him Sparky-#{Robot.count}."


# Trips Formatting-Error
# generator = -> { 'ABC123' }
# robot = Robot.new(name_generator: generator)
# puts "Robot #{Robot.count}'s name is #{robot.name}, but we usually call him Sparky-#{Robot.count}."


# Trips Collision-Error
# generator = -> { 'ABC12' }
# robot = Robot.new(name_generator: generator)
# puts "Robot #{Robot.count}'s name is #{robot.name}, but we usually call him Sparky-#{Robot.count}."
