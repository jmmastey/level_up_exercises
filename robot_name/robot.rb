NameCollisionError = Class.new(RuntimeError)
NameFormatError = Class.new(RuntimeError)

class Robot
  attr_accessor :robot_name

  def initialize(name_gen = nil)
    @@name_registry ||= []
    @name_generator = name_gen

    attempts = 0
    while attempts < 3
      @robot_name = generate_name
      break if valid_name?
      attempts += 1
    end

    find_error unless valid_name?
    @@name_registry << @robot_name
  end

  private

  def generate_name
    if @name_generator
      @name_generator.call
    else
      internal_name_generator
    end
  end

  private

  def internal_name_generator
    char_list = ('A'..'Z').to_a
    num_list = (0..9).to_a
    @robot_name = (1..2).inject("") { |name| name + char_list.sample }
    @robot_name += (1..3).inject("") { |name| name + num_list.sample.to_s }
  end

  private

  def name_already_in_list?
    @@name_registry.include?(@robot_name)
  end

  private

  def wrong_name_format?
    @robot_name[/^[[:alpha:]]{2}[[:digit:]]{3}$/].nil?
  end

  def valid_name?
    !(name_already_in_list? || wrong_name_format?)
  end

  private

  def find_error
    raise NameCollisionError, 'Name already in list.' if name_already_in_list?
    raise NameFormatError, 'Name has wrong format.' if wrong_name_format?
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.robot_name}, but we usually call him Rob."

# Errors!
#  generator = -> { 'AA111' }
# generator = -> { ('A'..'Z').to_a.sample }  # Will give incorrect format error
# Robot.new(name_generator: generator)
# Robot.new(name_generator: generator)
