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
