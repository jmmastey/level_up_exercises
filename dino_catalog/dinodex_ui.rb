require_relative "menus"
require_relative "dinosaur_catalog"

class DinodexUI
  HOME_MENU_OPTIONS = %w(Bipeds Carnivores Periods Sizes Search)

  def self.start(attr = {})
    @catalog = DinosaurCatalog.new(attr)

    @menu_index = :home
    load_sub_menus(@catalog.dinodex_periods)
    @action_menu = LetteredMenu.new(["JSON Save", "Back", "Quit"])

    clear_screen

    File.open('dinobanner.txt', 'r') { |f| puts f.read }

    run
  end

  def self.load_sub_menus(periods)
    @sub_menus = {
      home: Menu.new(HOME_MENU_OPTIONS),
      periods: Menu.new(periods),
      sizes: Menu.new(["Large dinosaurs", "Small dinosaurs"]),
      search: Menu.new("\nSearch with key:value. Chain searches with comma. "\
        "(eg: walking:biped,period:jurassic)\n"),
    }
  end

  def self.run
    @running = true

    while @running
      show_menu_options
      user_input = gets.chomp.downcase
      clear_screen
      handle_user_input(user_input)
    end
  end

  def self.clear_screen
    system("clear") || system("cls")
  end

  def self.show_menu_options
    @sub_menus[@menu_index].show
    @action_menu.show
  end

  def self.handle_user_input(user_input)
    if %w(j b q).include?(user_input)
      handle_action_menu(user_input)
    else
      handle_sub_menu_actions(user_input)
    end
  end

  def self.switch_menu(user_input)
    @menu_index = HOME_MENU_OPTIONS[user_input - 1].downcase.to_sym
  end

  def self.handle_action_menu(user_input)
    save_to_json if user_input == 'j'
    @menu_index = :home if user_input == 'b'
    @running = false if user_input == 'q'
  end

  def self.handle_sub_menu_actions(user_input)
    case @menu_index
      when :home
        handle_home_menu(user_input)
      when :periods
        show_dinos_by_period(user_input)
      when :sizes
        show_dinos_by_size(user_input)
      when :search
        handle_search_input(user_input)
    end
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

  def self.show_dinos_by_period(user_input)
    show_dinosaur_facts @catalog.find_dinos(
      :period, @catalog.dinodex_periods[user_input.to_i - 1].downcase
    )
  end

  def self.show_dinos_by_size(user_input)
    dinos = user_input == "1" ? @catalog.find_large : @catalog.find_small

    show_dinosaur_facts(dinos)
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
      @catalog.default_keys.each do |key|
        sym_key = key.to_sym

        puts "#{key.capitalize}: #{dino[sym_key]}" if dino[sym_key]
      end
      puts '-' * 80
    end
  end

  def self.save_to_json
    @catalog.export_to_json
    puts "Saved catalog to #{@catalog.json_file_name}"
  end
end
