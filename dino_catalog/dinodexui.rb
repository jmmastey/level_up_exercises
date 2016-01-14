require_relative "menus"
require_relative "dinosaur_catalog"

class DinodexUI
  attr_accessor :running
  attr_accessor :catalog
  attr_accessor :menu_text

  @menu_index = 0

  @action_menu = LetteredMenu.new(
    options: ["JSON Save", "Back", "Quit"],
    action: ->(user_input) { handle_action_menu(user_input) },
  )

  def self.current_sub_menu
    @sub_menus[@menu_index]
  end

  def self.start(attr = {})
    @catalog = DinosaurCatalog.new(attr)

    @sub_menus = [
      Menu.new(
        options: %w(Bipeds Carnivores Periods Sizes Search),
        action: ->(user_input) { handle_home_menu(user_input) },
      ),
      Menu.new(
        options: @catalog.dinodex_periods,
        action: ->(user_input) { show_dinos_by_period(user_input) },
      ),
      Menu.new(
        options: ["Show large dinosaurs", "Show small dinosaurs"],
        action: ->(user_input) { show_dinos_by_size(user_input) },
      ),
      Menu.new(
        help_text: "\nSearch with key:value. Chain searches with comma. "\
                    "(eg: walking:biped,period:jurassic)\n",
        action: ->(user_input) { handle_search_input(user_input) },
      ),
    ]

    run
  end

  def self.run
    clear_screen
    show_banner
    @running = true

    while @running
      show_menu_options
      handle_user_input
    end
  end

  def self.clear_screen
    system "clear" || "cls"
  end

  def self.show_banner
    File.open('dinobanner.txt', 'r') do |f|
      puts f.read
    end
  end

  def self.show_menu_options
    current_sub_menu.show
    @action_menu.show
  end

  def self.switch_menu(user_input)
    @menu_index = 1 if user_input == 3  # periods
    @menu_index = 2 if user_input == 4  # sizes
    @menu_index = 3 if user_input == 5  # search
  end

  def self.handle_user_input
    user_input = gets.chomp.downcase
    clear_screen
    current_sub_menu.handle_user_input(user_input) unless
      @action_menu.handle_user_input(user_input)
  end

  def self.handle_home_menu(user_input)
    user_input = user_input.to_i

    if user_input > 2
      switch_menu(user_input)
    else
      show_dinosaur_facts(@catalog.find_bipeds) if user_input == 1
      show_dinosaur_facts(@catalog.find_carnivores) if user_input == 2
    end
  end

  def self.handle_action_menu(user_input)
    save_to_json if user_input == 'j'
    back_to_home_menu if user_input == 'b'
    quit if user_input == 'q'
  end

  def self.show_dinos_by_period(user_input)
    show_dinosaur_facts @catalog.find_dinos(
      :period, @catalog.dinodex_periods[user_input.to_i - 1].downcase
    )
  end

  def self.show_dinos_by_size(user_input)
    case user_input
      when "1"
        show_dinosaur_facts @catalog.find_large_dinosaurs
      when "2"
        show_dinosaur_facts @catalog.find_small_dinosaurs
    end
  end

  def self.handle_search_input(user_input)
    index = nil
    user_input.split(',').each do |search|
      facet = search.split(':')
      index = @catalog.find_dinos(facet[0].to_sym, facet[1], index)
    end
    show_dinosaur_facts(index)
  end

  def self.show_dinosaur_facts(results)
    results.each do |dino|
      dino.each_pair do |key, val|
        puts "#{key.capitalize}: #{val}" if val
      end
      puts '-' * 80
    end
  end

  def self.save_to_json
    @catalog.export_to_json
    puts "Saved catalog to #{@catalog.json_file_name}"
    true
  end

  def self.back_to_home_menu
    @menu_index = 0
    true
  end

  def self.quit
    @running = false
  end
end
