class Bomb
  attr_accessor :status

  def initialize
    @status = default_status
  end

  def default_status
    "Inactive"
  end

end
