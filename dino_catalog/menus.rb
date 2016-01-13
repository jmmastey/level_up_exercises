class Menu
  attr_accessor :menu_options
  attr_accessor :menu_actions
  attr_accessor :default_action

  def initialize(attrs = {})
    attrs[:actions] ||= []

    @menu_options = attrs[:options]
    @menu_actions = attrs[:actions]
    @default_action = attrs[:default_action]
  end

  def show_options
    menu_text = ""
    @menu_options.each_with_index do |action, index|
      menu_text += "#{index + 1}) #{action} "
    end
    puts menu_text
  end

  def handle_user_input(user_input)
    index = user_input.to_i - 1

    if @menu_actions[index]
      @menu_actions[index].call(user_input)
    else
      @default_action.call(user_input)
    end
  end
end

class LetteredMenu < Menu
  def initialize(attrs = {})
    super(attrs)
    hashed_menu_options = {}
    @menu_options.each_with_index do |option, index|
      action = @menu_actions[index] ? @menu_actions[index] : @default_action
      hashed_menu_options[option[0].upcase] = { option: option, action: action }
    end
    @menu_options = hashed_menu_options
  end

  def show_options
    menu_text = ""
    @menu_options.each do |key, menu_action|
      menu_text += "#{key}) #{menu_action[:option]} "
    end
    puts menu_text
  end

  def handle_user_input(user_input)
    index = user_input.upcase
    @menu_options[index] ? @menu_options[index][:action].call(user_input) : nil
  end
end
