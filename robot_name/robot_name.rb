class NameCollisionError < RuntimeError
end

# A Random name will be created if you give no gudiance
# To allocate a name give an arg (name_generator: 'ted')
class Robot
  attr_accessor :name

  TWO_CHARS_THREE_NUMBERS = /[[:alpha:]]{2}[[:digit:]]{3}/

  @registry ||= []

  class << self
    attr_accessor :registry
  end

  def initialize(name_generator = nil)
    if name_generator.nil?
      create_new_name
    else
      allocate_name(name_generator)
    end

    register_name unless invalid_name?
  end

  private

  def allocate_name(name_generator)
    @name = name_generator
  end

  def invalid_name?
    name_alreadly_used? || incorrect_name_format?
  end

  def register_name
    Robot.registry << @name
    puts @name + " Registered"
  end

  def name_alreadly_used?
    fail NameCollisionError,
      'NO: Name Alreadly Used' if Robot.registry.include?(@name)
  end

  def incorrect_name_format?
    fail NameCollisionError,
      'NO: 2 Chars and 3 Digits' unless @name =~ TWO_CHARS_THREE_NUMBERS
  end

  def generate_char
    [*'A'..'Z'].sample
  end

  def generate_num
    rand(10).to_s
  end

  def create_new_name
    @name = "#{generate_char}#{generate_char}#{generate_num}#{generate_num}" \
      "#{generate_num}"
  end
end

puts "---"
robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."
puts "---"
robot = Robot.new('AA111')
puts "My pet robot's name is #{robot.name}, but we usually call him basil."
puts "---"
# puts "Will Fail"
# robot = Robot.new(name_generator: 'AA111')
# puts "My pet robot's name is #{robot.name}, but we usually call him basil."
# puts "---"
puts "Will Fail"
robot = Robot.new('Ted')
puts "My pet robot's name is #{robot.name}, but we usually call him basil."
