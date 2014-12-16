class Bomb
  attr_reader :id, :activation_code, :deactivation_code, :timer
  attr_accessor :status, :deactivation_attempts, :errors

  ACTIVE = "ACTIVE"
  INACTIVE = "Inactive"

  DEFAULT_ACTIVATE = 1234
  DEFAULT_DEACTIVATE = 1234

  def initialize(args)
    @activation_code = activation_check(args[:create_activation_code])
    @deactivation_code = deactivation_check(args[:create_deactivation_code])
    @status = INACTIVE
    @timer = Time.new(3000,11,1) # Far in the futre
    @deactivation_attempts = 0
    @errors = {}
  end

  def activate(input_code)
    if input_code == activation_code
      @status = ACTIVE
    end
  end

  def deactivate(input_code)
    if input_code == @deactivation_code
      @status = INACTIVE
    end
  end

  def active?
    @status == ACTIVE
  end

  def start_timer
    @timer = Time.now
  end

  def reset_timer
    @timer = Time.new(3000,11,1)
  end

  def timer_ended?
    Time.now >= timer + 7
  end

  def too_many_deactivation_attempts?
    deactivation_attempts >= 3
  end

  def deactivation_sequence
    reset_timer
    errors[:deactivate_error] = nil
    errors[:deactivate_status] = "Bomb has been deactivated"
  end

  def bad_deactivation_attempt
    errors[:deactivate_error] = "Incorrect code - ur still gonna blow!"
    # Why does this break unless it's an instance var?
    # Would ppl actually create a 'def deactivation_attempts+()' method?
    @deactivation_attempts += 1
  end

  private
  # TODO: Why are these methods necessary? (breaks if u do it the
  # logical way of "= args[:create_activation_code] ||= 1234" or 
  # even using .fetch() ...)
  def activation_check(args)
    args.empty? ? DEFAULT_ACTIVATE : args
  end

  def deactivation_check(args)
    args.empty? ? DEFAULT_DEACTIVATE : args
  end

end