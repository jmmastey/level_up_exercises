class NameCollisionError < RuntimeError
  def initialize(msg=nil)
    @message = msg
  end

  def message
    @message || default_message
  end

  def default_message
    "Tried to re-generate previously generated Robot Name"
  end

  private :default_message
end
