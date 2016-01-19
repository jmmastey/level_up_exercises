class Robot
  @created_names = []
  attr_accessor :name

  class << self
    attr_accessor :created_names
  end

  def initialize(wanted_name = nil)
    create_name(wanted_name)
    check_for_duplicate_name
    Robot.created_names << @name
  end

  private

  def create_name(wanted_name = nil)
    if wanted_name
      @name = wanted_name
    else
      @name = random_name
    end
  end

  def random_name
    generated_name = ""
    2.times { generated_name << [*'A'..'Z'].sample }
    3.times { generated_name << rand(10).to_s }
    generated_name
  end

  def check_for_duplicate_name
    return unless Robot.created_names.include?(@name)

    puts "There was a duplicate name, creating another random name"
    @name = random_name
    check_for_duplicate_name
  end
end

robot_1 = Robot.new
puts "My pet robot's name is #{robot_1.name}, but we usually call him sparky."
robot_2 = Robot.new
puts "My pet robot's name is #{robot_2.name}, but we usually call him riley."

robot_3 = Robot.new('AA111')
puts "My pet robot's name should be AA111 and it actually is #{robot_3.name}"
robot_4 = Robot.new('AA111')
puts "I tried to name two pet robots AA111, and the 2nd name is #{robot_4.name}"

puts "All the names of my robots are #{Robot.created_names}"
