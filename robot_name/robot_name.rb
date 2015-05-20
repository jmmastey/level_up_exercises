class NameCollisionError < RuntimeError; end

class Robot
  attr_accessor :name

  def initialize
    @@registry ||= []
    @name = generate_name(2, 3)
    @@registry << @name
  end

  def generate_name(number_of_letters, number_of_digits)
    new_name = ''
    (1..number_of_letters).each { new_name += ('A'..'Z').to_a.sample }
    (1..number_of_digits).each { new_name += rand(10).to_s }
    if name_exists?(new_name)
      raise NameCollisionError, "There was a problem generating the robot name!"
    end
    new_name
  end

  def name_exists?(name)
    name =~ /[[:alpha:]]{2}[[:digit:]]{3}/ || @@registry.include?(name)
  end
end

robot = Robot.new
p "My pet robot's name is #{robot.name}, but we usually call him sparky."
