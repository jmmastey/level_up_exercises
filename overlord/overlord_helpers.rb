module OverlordHelpers
  def trigger_bomb_state(trigger)
    if trigger.deactivated?
      trigger.activate(params[:code])
      incorrect_activation
    else
      trigger.deactivate(params[:code])
      incorrect_deactivation
    end
  end

  def incorrect_activation
    return unless trigger.deactivated?
    flash[:invalid_activation] = 'Incorrect activation code.'
  end

  def incorrect_deactivation
    return unless trigger.activated?
    flash[:invalid_deactivation] = 'Incorrect deactivation code.'
  end
end
