class BombPage < SitePrism::Page
  element :trigger_code, 'input[id=trigger-code]'
  element :bomb_state, 'input[id=change-bomb-state]'
  element :notice, 'label[id=notice]'
  element :bomb_status, 'caption[id=bomb-status]'
  element :timer_display_value, 'input[id=timer-output]'
  element :timer_value, 'input[id=timer-countdown]', visible: false
  element :timer_active, 'input[id=timer-started]', visible: false
  element :detonation, 'img[id=detonation]'

  def displayed_bomb_state
    bomb_status.text
  end

  def timer_display
    timer_display_value.value
  end

  def timer_value_in_seconds
    timer_value.value
  end

  def timer_state
    timer_active.value
  end

  def enter_code(code)
    trigger_code.set(code)
  end

  def activate_bomb
    bomb_state.click
  end

  def bomb_message
    notice.text
  end

  def check_if_detonated
    first('#detonation')
  end

  alias_method :deactivate_bomb, :activate_bomb
end
