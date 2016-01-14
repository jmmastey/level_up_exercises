class Menu
  attr_accessor :menu_options

  def initialize(options)
    @menu_options = Array(options)
  end

  def show
    show_options
    show_help_text
  end

  def show_options
    menu_text = ""
    @menu_options.each_with_index do |option, index|
      menu_text += "#{index + 1}) #{option} "
    end
    puts menu_text
  end

  def show_help_text
    puts @help_text
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
    @menu_options.each do |key, option|
      menu_text += "#{key}) #{option} "
    end
    puts menu_text
  end
end
