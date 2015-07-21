class Bomb
  OFF = 0
  ON = 1
  ACTIVATED = 2
  DEACTIVATED = 3
  DESTROYED = 4
  
  attr_accessor :start_time, :state, :activation_code, :deactivation_code
  
  def initialize(activation_code = 1234, deactivation_code = 0000)
    @state = OFF
    @activation_code = activation_code
    @deactivation_code = deactivation_code
  end

  def boot_up
    @state = ON
  end

  def activate
    @state = ACTIVATED if on?
  end

  def deactivate
    @state = DEACTIVATED if activated?
  end

  def detonate
    @state = DESTROYED if activated?
  end

  def on?
    @state == ON
  end

  def off?
    @state == OFF
  end

  def activated?
    @state == ACTIVATED
  end

  def deactivated?
    @state == DEACTIVATED
  end

  def destroyed?
    @state == DESTROYED
  end
end