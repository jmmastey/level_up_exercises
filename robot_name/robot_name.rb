class Robot
  attr_reader :name

  def initialize(args = {})
    @@registry ||= []
    self.name = args[:name_generator] ? args[:name_generator] : generate_name
    @@registry << @name
  end

  def name=(value)
    @name = value if check_duplicate?(value)
  end

  def self.registry
    @@registry
  end

  def check_duplicate?(str)
    if !@@registry.include?(str)
      true
    else
      puts "A robot named '#{str}' already exists. Skipping robot."
      return false
    end
  end

  def generate_name
    generate_char = -> { ('A'..'Z').to_a.sample }
    generate_num = -> { rand(10) }

    2.times.collect { generate_char.call }.join +
      3.times.collect { generate_num.call }.join
  end
end

50.times do
  robot = Robot.new
  puts "My pet robot's name is #{robot.name}, but we usually call him sparky."
end

puts Robot.registry
