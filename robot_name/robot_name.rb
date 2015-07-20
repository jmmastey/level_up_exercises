class NameCollisionError < RuntimeError; end

class Robot
  attr_accessor :name

  def initialize(args = {})
    @@registry ||= []
    @name_generator = args[:name_generator]

    check_name_instance_and_generate_name

    raise_name_error unless name_valid?
    @@registry << @name
  end

  def check_name_instance_and_generate_name
    if @name_generator
      @name = @name_generator.call
      generate_new_name if already_registered?(@name)
    else
      generate_name
    end
  end

  def generate_name
    @name = "#{generate_char}" \
            "#{generate_char}" \
            "#{generate_num}" \
            "#{generate_num}"\
            "#{generate_num}"
  end

  def generate_new_name
    generate_name
  end

  def generate_char
    ('A'..'Z').to_a.sample
  end

  def generate_num
    rand(10)
  end

  def already_registered?(name)
    @@registry.include?(name)
  end

  def raise_name_error
    raise NameCollisionError, 'There was a problem generating the robot name!'
  end

  def name_valid?
    (name =~ /[[:alpha:]]{2}[[:digit:]]{3}/) || @@registry.include?(name)
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# No more errors!
generator = -> { 'AA111' }
puts Robot.new(name_generator: generator).name
puts Robot.new(name_generator: generator).name
