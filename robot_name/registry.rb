require_relative 'name_collision_error'
require_relative 'pattern_error'

class RobotNameRegistry
  UPPER_COUNT = 2
  DIGIT_COUNT = 3
  DEFAULT_SCHEMA = "[[:upper:]]{#{UPPER_COUNT}}[[:digit:]]{#{DIGIT_COUNT}}"

  def initialize(schema  = nil)
    @registry = []
    @schema   = schema  || DEFAULT_SCHEMA
  end

  def generate_name(name_generator = nil)
    name_generator ||= method(:default_name_generator)
    name = name_generator.call
    validate(name)
    @registry << name
    name
  end

  def default_name_generator
    loop do
      upper_portion = UPPER_COUNT.times.map { ('A'..'Z').to_a.sample }.join
      digit_portion = DIGIT_COUNT.times.map { rand(10) }.join
      name = upper_portion + digit_portion
      return name unless exists?(name)
    end
  end

  def exists?(name)
    @registry.include?(name)
  end

  def matches_schema?(name)
    !!(name =~ Regexp.new(@schema))
  end

  def validate(name)
    raise NameCollisionError if exists?(name)
    raise PatternError unless matches_schema?(name)
  end
end
