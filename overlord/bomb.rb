class Bomb
  DEFAULT_ACTIVATION_CODE = "1234"
  DEFAULT_DEACTIVATION_CODE = "0000"
  RETRY_LIMIT = 3
  COUNTDOWN = 60
  BOMB_STATUS = { inactive: "INACTIVE", active: "ACTIVE", explode: "EXPLODE" }
  attr_reader :activate_code, :deactivate_code, :status, :retry

  def initialize(activation_code = DEFAULT_ACTIVATION_CODE,
                 deactivation_code = DEFAULT_DEACTIVATION_CODE)
    @activate_code = activation_code
    @deactivate_code = deactivation_code
    @status = BOMB_STATUS[:inactive]
    @retry = 0
  end

  def self.default_activation_code
    DEFAULT_ACTIVATION_CODE
  end

  def self.default_deactivation_code
    DEFAULT_DEACTIVATION_CODE
  end

  def retry_limit
    RETRY_LIMIT
  end

  def retry_count
    @retry += 1
  end

  def reset_retry
    @retry = 0
  end

  def self.valid_code?(code)
    code.match(/^\d{4}$/) ? true : false
  end

  def activate(code)
    @status = BOMB_STATUS[:active] if authenticate_activation_code?(code)
  end

  def deactivate(code)
    @status = BOMB_STATUS[:inactive] if authenticate_deactivation_code?(code)
  end

  def explode
    @status = BOMB_STATUS[:explode]
  end

  def countdown
    COUNTDOWN
  end

  private

  def authenticate_activation_code?(code)
    code.match(@activate_code) ? true : false
  end

  def authenticate_deactivation_code?(code)
    code.match(@deactivate_code) ? true : false
  end
end
