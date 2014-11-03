class NameGeneratorError < RuntimeError
  def initialize(message = nil)
    message ||= "Provided name generator is not valid"
    super
  end
end
