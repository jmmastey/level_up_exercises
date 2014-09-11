class NameCollisionError < RuntimeError; end;

class Robot
  attr_accessor :name

  @@registry

  def initialize(args = {})
    @@registry ||= []
    @name_generator = args[:name_generator]

    generate_name

    if naming_issue?
      raise NameCollisionError, naming_issue_msg
    end
  end

  private

  def naming_issue?
    !(name =~ /[[:alpha:]]{2}[[:digit:]]{3}/) || @@registry.include?(name)
  end

  def naming_issue_msg
    "There was a problem generating the robot name!"
  end

  def generate_name
    if @name_generator
      @name = @name_generator.call
    else
      @name = [generate_char,
               generate_char,
               generate_num,
               generate_num,
               generate_num
              ].join
    end
  end

  def generate_num
    rand(10)
  end

  def generate_char
    ("A".."Z").to_a.sample
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

