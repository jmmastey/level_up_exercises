module BombStateHelper
  def bomb_does(*args)
    action = "#{args.shift}!".to_sym
    result = ($bomb || Overlord::Bomb).send(*args.unshift(action))
    $bomb ||= result
  rescue => e
    $errors << e
  end

  def clear_state
    $bomb = nil
    clear_errors
  end

  def clear_errors
    $errors = []
  end
end
World(BombStateHelper)

Before('@clear_state') { clear_state }
Before('@clear_errors') { clear_errors }

# Tell Cucumber to quit after this scenario is done - if it failed.
After { |s|  Cucumber.wants_to_quit = true if s.failed? }
