class NameCollisionError < RuntimeError
  def initialize(msg = nil)
    @message = msg
  end

  def message
    @message || 'Tried to re-generate previously generated Robot Name'
  end
end
