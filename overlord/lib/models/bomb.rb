class Bomb
  attr_reader :id, :activation_code, :deactivation_code
  attr_accessor :status

  ACTIVE = "ACTIVE"
  INACTIVE = "Inactive"

  def initialize(args)
    # TODO: Why are these necessary?
    @activation_code = activation_code_check(args[:create_activation_code])
    @deactivation_code = deactivation_code_check(args[:create_deactivation_code])
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

  def deactivate(input_code)
    if input_code == @deactivation_code
      @status = INACTIVE
    end
  end

  private

  def activation_code_check(args)
    args.empty? ? 1234 : args
  end

  def deactivation_code_check(args)
    args.empty? ? 1234 : args
  end

end