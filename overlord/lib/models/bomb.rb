class Bomb
  attr_reader :activation_code, :deactivation_code, :timer
  attr_accessor :status, :deactivation_attempts, :messages

  ACTIVE = "ACTIVE"
  INACTIVE = "Inactive"

  DEFAULT_ACTIVATE = 1234
  DEFAULT_DEACTIVATE = 1234

  def initialize(args)
    @activation_code = activation_check(args[:create_activation_code])
    @deactivation_code = deactivation_check(args[:create_deactivation_code])
    @status = INACTIVE
    # TODO: Better way to do this...
    @timer = Time.new(3000, 11, 1) # Far in the futre
    @deactivation_attempts = 0
    @messages
  end

  def activate(input_code)
    @status = ACTIVE if input_code == activation_code
  end

  def deactivate(input_code)
    @status = INACTIVE if input_code == @deactivation_code
  end

  def active?
    @status == ACTIVE
  end

  def start_timer
    @timer = Time.now
  end

  def reset_timer
    @timer = Time.new(3000, 11, 1)
  end

  def timer_ended?
    Time.now >= timer + 7
  end

  def too_many_deactivation_attempts?
    deactivation_attempts >= 3
  end

  private

  def activation_check(args)
    args.empty? ? DEFAULT_ACTIVATE : args
  end

  def deactivation_check(args)
    args.empty? ? DEFAULT_DEACTIVATE : args
  end
end
