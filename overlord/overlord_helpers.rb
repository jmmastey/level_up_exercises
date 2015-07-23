module OverlordHelpers
  def provide_bomb
    trigger = Trigger.new(activate: session[:activate],
        deactivate: session[:deactivate])

    session[:countdown] = 30 if session[:countdown].empty?

    timer = Timer.new(session[:countdown].to_i)

    Bomb.new(trigger: trigger, timer: timer)
  end

  def trigger_bomb_state(trigger, timer)
    if trigger.deactivated?
      trigger.activate(params[:code])
      timer.start unless incorrect_activation
    else
      trigger.deactivate(params[:code])
      timer.stop unless incorrect_deactivation
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
