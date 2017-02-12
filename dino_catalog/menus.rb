class Menu
  def initialize(options)
    @menu_options = Array(options)
  end

  def show
    if @menu_options.length == 1
      puts @menu_options[0]
    else
      show_options
    end
  end

  private

  def show_options
    menu_text = ""
    @menu_options.each_with_index do |option, index|
      menu_text += "#{index + 1}) #{option} "
    end
    puts menu_text
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

  private

  def show_options
    menu_text = ""
    @menu_options.each do |key, option|
      menu_text += "#{key}) #{option} "
    end
    puts menu_text
  end
end
