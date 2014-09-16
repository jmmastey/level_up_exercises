class NameCollisionError < RuntimeError
  def to_s
    'There was a problem generating the robot name!'
  end
end

class Robot
  attr_accessor :name

  @@registry ||= []

  def initialize(name_generator: nil)
    init_generator(name_generator)
    generate_name
  end

  protected

  def init_generator(generator)
    @name_generator = generator || default_generator
  end

  def generate_name(generator = @name_generator)
    @name = generator.call
    fail NameCollisionError unless name_valid?
    @@registry << @name
  end

  def default_generator
    proc { |prefix = ''| prefix << "#{generate_char(2)}#{generate_num(3)}" }
  end

  def name_valid?
    (name =~ /[[:alpha:]]{2}[[:digit:]]{3}/) && !@@registry.include?(name)
  end

  private

  def generate_char(num = 1, prefix = '')
    c = -> { ('A'..'Z').to_a.sample }
    generate_string(c, num, prefix)
  end

  def generate_num(num = 1, prefix = '')
    n = -> { rand(10) }
    generate_string(n, num, prefix)
  end

  def generate_string(gen_proc, num = 1, prefix = '')
    (1..num).inject(prefix) { |a, _| a << "#{gen_proc.call}" }
  end
end
