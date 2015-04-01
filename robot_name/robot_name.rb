class Robot
  attr_accessor :name
  require_relative 'name_generator'

  def initialize()
    @name = NameGenerator.call
  end
end

robot = Robot.new
robot2 = Robot.new
puts "My pet robots names are #{robot.name} and #{robot2.name}..."+
" but I never talk to them."
