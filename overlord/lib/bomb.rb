require 'SecureRandom'

class Bomb
  attr_accessor :activation_code, :deactivation_code, :status, :timer, :attempts,
                :explode_pin

  def initialize(activation_code, deactivation_code)
    @activation_code = activation_code
    @deactivation_code = deactivation_code
    @status = 'inactive'
    @timer = 0
    @attempts = 0
  end

  def valid?
    return false unless activation_code =~ /^\d{4}$/
    return false unless deactivation_code =~ /^\d{4}$/
    true
  end

  def correct_activation_code?(code)
    activation_code.eql?(code)
  end

  def activate
    @status = 'armed'
    # Set the bomb to explode in 60 seconds
    @timer = Time.now.to_i + 60
    @explode_pin = SecureRandom.random_number(100_000_000)
  end

  def correct_deactivation_code?(code)
    deactivation_code.eql?(code)
  end

  def deactivate
    @status = 'deactivated'
    @timer = 0
  end

  def increment_deactivation_code_attempts
    @attempts += 1
  end

  def reached_deactivation_attempt_limit?
    @attempts == 3
  end

  def explode
    @status = 'exploded'
    @timer = 0
  end

  def exploded?
    timer > Time.now.to_i || status.eql?('exploded')
  end

  def correct_explode_pin?(pin)
    @explode_pin == pin.to_i
  end

  def active?
    @status == 'armed' && !exploded?
  end
end
