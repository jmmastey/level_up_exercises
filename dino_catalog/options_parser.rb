class OptionsParser
  ACTION_MAP = {
    "all"        => :print_all,
    "biped"      => :print_bipeds,
    "large"      => :print_large,
    "carnivores" => :print_meat_eaters,
    "period"     => :print_from_period,
    "exit"       => :exit,
  }

  def get_action(user_input)
    ACTION_MAP[user_input.downcase.strip]
  end
end
