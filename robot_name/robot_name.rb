class NameCollisionError < RuntimeError
end

# A Random name will be created if you give no gudiance
# To allocate a name give an arg (name_generator: 'ted')
class Robot
  attr_accessor :name

  @registry ||= []

  class << self
    attr_accessor :registry
  end

  def initialize(args = {})
    @name_generator = args[:name_generator]
    create_or_allocate_name
    check_and_register_name
  end

  def create_or_allocate_name
    if @name_generator
      @name = @name_generator
    else
      create_new_name
    end
  end

  def check_and_register_name
    if name_alreadly_used? || incorrect_name_format?
      return
    else
      Robot.registry << @name
      puts @name + " Registered"
    end
  end

  def name_alreadly_used?
    fail NameCollisionError,
      'NO: Name Alreadly Used' if Robot.registry.include?(@name)
  end

  def incorrect_name_format?
    fail NameCollisionError,
      'NO: 2 CHARs and 3 Digits' unless @name =~ /[[:alpha:]]{2}[[:digit:]]{3}/
  end

  def generate_char
    ('A'..'Z').to_a.sample
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
robot = Robot.new(name_generator: 'AA111')
puts "My pet robot's name is #{robot.name}, but we usually call him basil."
puts "---"
# puts "Will Fail"
# robot = Robot.new(name_generator: 'AA111')
# puts "My pet robot's name is #{robot.name}, but we usually call him basil."
# puts "---"
puts "Will Fail"
robot = Robot.new(name_generator: 'Ted')
puts "My pet robot's name is #{robot.name}, but we usually call him basil."
