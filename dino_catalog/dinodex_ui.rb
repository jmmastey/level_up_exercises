require_relative "menu"
require_relative "lettered_menu"
require_relative "dinosaur_catalog"
require_relative "dinosaur_view"

class DinodexUI
  HOME_MENU_OPTIONS = %w(Bipeds Carnivores Periods Sizes Search)

  def self.start(attr = {})
    @catalog = DinosaurCatalog.new(attr)

    @menu_index = :home
    load_sub_menus(@catalog.dinosaur_catalog_periods)
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
      handle_user_input
    end
  end

  def self.handle_user_input
    user_input = collect_user_input

    if %w(b j q).include? user_input
      handle_menu_options(user_input)
    else
      handle_sub_menu_actions(user_input)
    end
  end

  def self.stop_running
    @running = false
  end

  def self.collect_user_input
    user_input = gets.chomp
    clear_screen
    user_input.downcase
  end

  def self.clear_screen
    system("clear") || system("cls")
  end

  def self.show_menu_options
    @sub_menus[@menu_index].show
    @action_menu.show
  end

  def self.switch_menu(user_input)
    @menu_index = user_input
  end

  def self.handle_menu_options(user_input)
    switch_menu(:home) if user_input == 'b'
    save_to_json if user_input == 'j'
    stop_running if user_input == 'q'
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
    option = HOME_MENU_OPTIONS[user_input.to_i - 1].downcase.to_sym

    case option
      when :bipeds
        show_dinosaur_facts(@catalog.find_bipeds)
      when :carnivores
        show_dinosaur_facts(@catalog.find_carnivores)
      else
        switch_menu(option)
    end
  end

  def self.show_dinos_by_period(user_input)
    selected_period = @catalog.dinosaur_catalog_periods[
      user_input.to_i - 1
    ].downcase

    dinos = @catalog.find_dinos(
      :period, selected_period
    )

    show_dinosaur_facts(dinos)
  end

  def self.show_dinos_by_size(user_input)
    dinos = (user_input == "1") ? @catalog.find_large : @catalog.find_small
    show_dinosaur_facts(dinos)
  end

  def self.handle_search_input(user_input)
    catalog = nil
    user_input.split(',').each do |search|
      facet = search.split(':')
      key = facet[0].to_sym
      val = facet[1]
      catalog = @catalog.find_dinos(key, val, catalog)
    end
    show_dinosaur_facts(catalog)
  end

  def self.show_dinosaur_facts(results)
    DinosaurView.show(dinos: results)
  end

  def self.save_to_json
    @catalog.export_to_json
    puts "Saved catalog to #{@catalog.json_file_name}"
  end
end
