require './dinodex_filter'

def main
  @dinodex = DinodexFilter.new

  loop do
    print_menu

    user_input = prompt_and_get_user_input('select: ')

    handle_user_input(user_input)
    puts ''
  end
end

def print_menu
  puts '1. bipeds'
  puts '2. carnivores'
  puts '3. period'
  puts '4. big'
  puts '5. small'
  puts '6. name'
  puts 'c. chain'
  puts 'r. reset chain'
  puts 'p. print last result'
  puts 'q. quit'
end

def handle_user_input(user_input)
  case user_input
  when '1'
    @dinodex.filter('bipeds')
  when '2'
    @dinodex.filter('carnivores')
  when '3'
    period = prompt_and_get_user_input('period: ')
    @dinodex.filter('period', period)
  when '4'
    @dinodex.filter('big')
  when '5'
    @dinodex.filter('small')
  when '6'
    name = prompt_and_get_user_input('name: ')
    @dinodex.filter('name', name)
  when 'c'
    @dinodex.update_filtered_catalog
  when 'r'
    @dinodex.reset_filtered_catalog
  when 'p'
    @dinodex.print_last_result
  when 'q'
    exit
  end
end

def prompt_and_get_user_input(prompt)
  print prompt
  user_input = gets.chomp
  puts ''

  user_input
end

main
