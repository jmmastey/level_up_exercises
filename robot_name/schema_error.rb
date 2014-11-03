class SchemaError < RuntimeError
  def initialize(message = nil)
    message ||= "Generated name does not conform to a valid schema"
    super
  end
end