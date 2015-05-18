class RobotManager
  REG_EXP_NAME =  /[[:alpha:]]{2}[[:digit:]]{3}/
  NAME_INPUT_ERROR = "There was a problem with the user's robot name!"
  
  def initialize
    @registry = []
  end

  def create_robots(number_of_robots, *arg)
    #REG_EXP_NAME =  /[[:alpha:]]{2}[[:digit:]]{3}/ 
    #NAME_INPUT_ERROR = "There was a problem with the user's robot name!"
    
    robots = []
    (0...number_of_robots).each do |i|
      robot_name = arg[i] ||  NameGenerator.new.generate_name 
      raise NameInputError, NAME_INPUT_ERROR if !(robot_name =~ REG_EXP_NAME)
      #if arg[i].nil?
      #  robot_name = Robot.new(NameGenerator.new.generate_name).name
      #else
      #  robot_name = Robot.new(arg[i]).name
      #end
      Robot.new(robot_name)
      raise NameCollisionError, "Oh noes! #{robot_name} is a duplicate name." if  @registry.include?(robot_name)
      @registry << robot_name
      puts "My robot's name is #{robot_name}, but we usually call her Sparkles!"
      robots << robot_name
    end
  end
end

class Robot
  attr_accessor :name

  def initialize(name)
  @name = name
  end
end

class NameGenerator
  REG_EXP_NAME =  /[[:alpha:]]{2}[[:digit:]]{3}/
  NAME_GEN_ERROR = "There was a problem generating the robot name!"

  def generate_name
    name=''
    name = [1,2,3,4,5].inject("") do |name, i|
      i < 3 ? name << [*'A'..'Z'].sample : name << rand(10).to_s
    end
    raise NameGeneratorError, NAME_GEN_ERROR if !(name =~ REG_EXP_NAME)
    name
  end
end

class NameCollisionError < RuntimeError; end

class NameGeneratorError < RuntimeError; end

class NameInputError < RuntimeError; end


robot_manager = RobotManager.new
robot_manager.create_robots(13)
robot_manager.create_robots(3, "AA111", "A11", "AA111")

#robot = Robot.new
#puts "My pet robot's name is #{robot.name}, but we usually call him sparky."
#robot = Robot.new
#puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
#test_name = 'AA111'
#robot = Robot.new(test_name)
#puts "My pet robot's name is #{robot.name}, but we usually call him sparky."
#robot = Robot.new(name_generator: generator)
#puts "My pet robot's name is #{robot.name}, but we usually call him sparky."
