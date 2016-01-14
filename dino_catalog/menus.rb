class Menu
  attr_accessor :menu_options
  attr_accessor :action

  def initialize(attrs = {})
    @menu_options = Array(attrs[:options])
    @action = attrs[:action]
    @help_text = attrs[:help_text]
  end

  def show
    show_options
    show_help_text
  end

  def show_options
    menu_text = ""
    @menu_options.each_with_index do |action, index|
      menu_text += "#{index + 1}) #{action} "
    end
    puts menu_text
  end

  def show_help_text
    puts @help_text
  end

  def handle_user_input(user_input)
    @action.call(user_input)
  end
end

class LetteredMenu < Menu
  def initialize(attrs = {})
    super(attrs)
    hashed_menu_options = {}
    @menu_options.each do |option|
      hashed_menu_options[option[0].upcase] = option
    end
    @menu_options = hashed_menu_options
  end

  def show_options
    menu_text = ""
    @menu_options.each do |key, action|
      menu_text += "#{key}) #{action} "
    end
    puts menu_text
  end

  def handle_user_input(user_input)
    index = user_input.upcase
    @menu_options[index] ? @action.call(user_input) : nil
  end
end
