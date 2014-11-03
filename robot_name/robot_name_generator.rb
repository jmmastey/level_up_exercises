require_relative 'schema_error'
require_relative 'name_generator_error'

class RobotNameGenerator
  UPPER_COUNT    = 2
  DIGIT_COUNT    = 3
  DEFAULT_SCHEMA = "[[:upper:]]{#{UPPER_COUNT}}[[:digit:]]{#{DIGIT_COUNT}}"

  def initialize(schema = nil)
    @schema = schema || DEFAULT_SCHEMA
  end

  def generate(generator = nil)
    generator ||= method(:default_generator)
    name = generator.call
    validate(name)
    name
  end

  private

  def validate(name)
    raise SchemaError unless name =~ Regexp.new(@schema)
  end

  def default_generator
    UPPER_COUNT.times.map { ('A'..'Z').to_a.sample }.join +
      DIGIT_COUNT.times.map { rand(10) }.join
  end
end
