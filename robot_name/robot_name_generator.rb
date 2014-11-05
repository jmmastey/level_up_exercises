FormatError = Class.new(RuntimeError)

class RobotNameGenerator
  DEFAULT_FORMAT = /^[[:upper:]]{2}[[:digit:]]{3}$/

  def initialize(params = {})
    @generator = params[:name_generator] || method(:default_generator)
    @pattern   = params[:pattern] || DEFAULT_FORMAT
  end

  def generate
    @generator.call.tap { |name| validate(name) }
  end

  private

  def validate(name)
    error_message = "Generated name #{name} is not in a valid format"
    raise FormatError, error_message unless name =~ @pattern
  end

  def default_generator
    2.times.map { ('A'..'Z').to_a.sample }.join + 3.times.map { rand(10) }.join
  end
end
