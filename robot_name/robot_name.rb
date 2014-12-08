class NameCollisionError < RuntimeError
  def to_s
    'There was a problem generating the robat name'
  end
end

class Robot
  attr_accessor :name, :registry

  def initialize(args = {})
    @registry ||= []
    @name = []
    if (@name_generator = args[:name_generator])
      @name = @name_generator.call
    else
      generate_char = -> { ('A'..'Z').to_a.sample }
      generate_num = -> { rand(10) }
      2.times { @name << generate_char.call}
      3.times { @name << generate_num.call}
      @name = @name.join('')
    end
    check_name(name)
    @registry << @name
  end

  def check_name(name)
    raise NameCollisionError if @registry.include?(name)
    raise NameCollisionError unless name =~ /[[:alpha:]]{2}[[:digit:]]{3}/
  end

end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
# generator = -> { 'AA111' }
# Robot.new(name_generator: generator)
# Robot.new(name_generator: generator)
