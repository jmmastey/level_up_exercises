require_relative './menu'

class LetteredMenu < Menu
  def initialize(attrs = {})
    super(attrs)
    hashed_menu_options = {}
    @menu_options.each do |option|
      hashed_menu_options[option[0].upcase] = option
    end
    @menu_options = hashed_menu_options
  end

  private

  def show_options
    menu_text = ""
    @menu_options.each do |key, option|
      menu_text += "#{key}) #{option} "
    end
    puts menu_text
  end
end
