class NameCollisionError < RuntimeError
  def initialize
    msg = 'There was a problem generating the robot name!'
    super msg
  end
end
