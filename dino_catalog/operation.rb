class Operation
  attr_reader :message, :operation

  def initialize(message, operation)
    @message = message
    @operation = operation
  end

  def call(item)
    @operation.call(item)
  end
end
