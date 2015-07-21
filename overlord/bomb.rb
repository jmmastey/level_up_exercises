class Bomb
  OFF = 1
  BOOTED = 2
  ACTIVATED = 3
  DEACTIVATED = 4
  EXPLODED = 5

  DEFAULT_NUM_ATTEMPTS = 3

  attr_accessor :state, :activation_code, :deactivation_code, :attempts

  def initialize(activation_code = '1234', deactivation_code = '0000')
    @activation_code = activation_code
    @deactivation_code = deactivation_code
    @state = valid_codes? ? BOOTED : OFF
    @attempts = DEFAULT_NUM_ATTEMPTS
  end

  def valid_codes?
    @activation_code =~ /^[0-9]+$/ && @deactivation_code =~ /^[0-9]+$/
  end

  def update_codes(params)
    @activation_code = params["activation_code"]
    @deactivation_code = params["deactivation_code"]
    @state = BOOTED if valid_codes?
  end

  def activate(code)
    @state = ACTIVATED if @activation_code == code
  end

  def deactivate(code)
    if @deactivation_code == code
      @state = DEACTIVATED
      return
    end

    @attempts -= 1
    explode if @attempts == 0
  end

  def explode
    @state = EXPLODED
  end

  def off?
    @state == OFF
  end

  def booted?
    @state == BOOTED
  end

  def activated?
    @state == ACTIVATED
  end

  def deactivated?
    @state == DEACTIVATED
  end

  def exploded?
    @state == EXPLODED
  end
end
