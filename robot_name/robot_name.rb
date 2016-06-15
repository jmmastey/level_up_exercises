class Robot
  CHARS = ('A'..'Z').to_a
  NUMS = (0..10).to_a

  attr_accessor :name

  def initialize(options = {})
    @registry = []
    add_name_to_registry(options)
  end

  def generate_name
    name = ""
    2.times { name += CHARS.sample }
    3.times { name += NUMS.sample.to_s }
    name
  end

  def add_name_to_registry(options)
    @name = options[:name] || generate_name
    raise "Duplicate Error" if duplicate_name?
    @registry << @name
  end

  def duplicate_name?
    @registry.include?(@name)
  end
end

name = 'AA111'
robot = Robot.new(name: name)
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."
# Robot.new(name: name)
# Robot.new(name: name)
