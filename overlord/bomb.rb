# This is the main class for the overlord program
class Bomb
  attr_accessor :activation_code
  attr_accessor :deactivation_code
  attr_accessor :status_indicator
  attr_accessor :wrong_deactivate_attempts
  attr_accessor :wrong_activate_attempts
  attr_accessor :entered_activation_code
  attr_accessor :entered_deactivation_code

  def initialize
    @wrong_deactivate_attempts = 0
    @wrong_activate_attempts = 0
    @status_indicator = 'inactive'
    @blow_up = ''
    @invalid_code = ''
    @invalid_format = ''
  end

  def activate_code(code, entered_code)
    @status_indicator = 'active' if valid_bomb_codes?(code, entered_code)
    @status_indicator = 'inactive' unless valid_bomb_codes?(code, entered_code)
    @wrong_activate_attempts += 1  unless valid_bomb_codes?(code, entered_code)
    @status_indicator
  end

  def valid_bomb_codes?(code, entered_code)
    !!(code == entered_code && code =~ /^\d{4}$/)
  end

  def valid_boot_codes?(boot_activation_code, boot_deactivation_code)
    !!(boot_activation_code =~ /^\d{4}$/ && boot_deactivation_code =~ /^\d{4}$/)
  end

  def deactivate_code(code, entered_code)
    @status_indicator = 'inactive' if valid_bomb_codes?(code, entered_code)
    @status_indicator = 'active' unless valid_bomb_codes?(code, entered_code)
    @wrong_deactivate_attempts += 1 unless valid_bomb_codes?(code, entered_code)
    @status_indicator
  end
end
