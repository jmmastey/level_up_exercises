class Bomb
  attr_accessor :countdown_time, :countdown_start_time, :current_state_index
  attr_reader :activation_code, :deactivation_code

  DEFAULT_ACTIVATION_CODE = '1234'
  DEFAULT_DEACTIVATION_CODE = '0000'
  DEFAULT_COUNTDOWN_TIME = 30000
  STATES = [ :activation, :deactivation, :standby, :armed, :exploded ]

  def initialize
    @activation_code = CodeSequence.new DEFAULT_ACTIVATION_CODE
    @deactivation_code = CodeSequence.new DEFAULT_DEACTIVATION_CODE
    @current_state_index = 0
    @countdown_time = 0
  end

  def update_countdown_time(time=DEFAULT_COUNTDOWN_TIME)
    @countdown_time = time
    @countdown_start_time = Time.now
  end

  def current_state
    { name: STATES[@current_state_index], index: @current_state_index }
  end
end