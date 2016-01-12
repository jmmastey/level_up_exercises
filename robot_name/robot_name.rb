class Robot
  @created_names = []
  attr_accessor :name

  class << self
    attr_accessor :created_names
  end

  def initialize(args = {})
    create_name(args[:name_generator])
    check_for_duplicate_name
    Robot.created_names << @name
  end

  def create_name(name_generator = nil)
    if name_generator.nil?
      @name = random_name
    else
      @name = name_generator.call
    end
  end

  def random_name
    generated_name = ""
    2.times { generated_name << ('A'..'Z').to_a.sample }
    3.times { generated_name << rand(10).to_s }
    generated_name
  end

  def check_for_duplicate_name
    return unless Robot.created_names.include?(@name)

    @name = random_name
    puts "There was a duplicate name, creating another random name"
    check_for_duplicate_name
  end
end

robot_1 = Robot.new
puts "My pet robot's name is #{robot_1.name}, but we usually call him sparky."
robot_2 = Robot.new
puts "My pet robot's name is #{robot_2.name}, but we usually call him riley."

generator = -> { 'AA111' }
robot_3 = Robot.new(name_generator: generator)
puts "My pet robot's name should be AA111 and it actually is #{robot_3.name}"
robot_4 = Robot.new(name_generator: generator)
puts "I tried to name two pet robots AA111, and the 2nd name is #{robot_4.name}"

puts "All the names of my robots are #{Robot.created_names}"
