module Overlord
  module ViewHelpers
    def placeholder_string
      case bomb_status
        when :unbooted    then "[activation_code]"
        when :deactivated then "[activation_code] [deactivation_code]"
        when :activated   then "deactivation_code"
      end
    end

    def attempts_string
      " (attempts: #{session[:bomb].attempts})" if bomb_status == :activated
    end

    def notify(message = nil)
      session[:notification] = message
    end

    alias_method :unnotify, :notify

    def still_dead?
      notify("And.. you're still dead.") if bomb_status == :exploded
    end
  end
end
