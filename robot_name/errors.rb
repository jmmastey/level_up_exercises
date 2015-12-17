class NameCollisionError < RuntimeError
  def initialize(msg = "That name already exists")
    super
  end
end

class NameInvalidError < RuntimeError
  def initialize(msg = "That name is invalid")
    super
  end
end
