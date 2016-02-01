require_relative './menu'

class LetteredMenu < Menu
  def initialize(attrs = {})
    super(attrs)
    @menu_options = @menu_options.each_with_object({}) do |option, obj|
      obj[option[0].upcase] = option
    end
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
