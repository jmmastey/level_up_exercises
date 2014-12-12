class Bomb
  attr_reader :id, :activation_code
  attr_accessor :status

  ACTIVE = "ACTIVE"
  INACTIVE = "Inactive"

  def initialize(args)
    @activation_code = args[:create_activation_code]
    @status = INACTIVE
  end

  def activate(input_code)
    if input_code == activation_code
      @status = ACTIVE
    end
  end

  def active?
    @status == ACTIVE
  end
end