require './dinodex_handler'

def main
  @dinodex_handler = DinodexHandler.new
  @dinodex_handler.setup_chain

  loop do
    print_prompt

    user_input = gets.chomp
    puts ''

    handle_user_input(user_input)
    puts ''
  end
end

def print_prompt
  puts '1. bipeds'
  puts '2. carnivores'
  puts '3. period'
  puts '4. size'
  puts '5. name'
  puts 'c. chain'
  puts 'r. reset chain'
  puts 'p. print last result'
  puts 'q. quit'
  print 'select: '
end

def handle_user_input(user_input)
  case user_input
  when '1'
    @dinodex_handler.handle_bipeds_option
  when '2'
    @dinodex_handler.handle_carnivores_option
  when '3'
    @dinodex_handler.handle_period_option
  when '4'
    @dinodex_handler.handle_size_option
  when '5'
    @dinodex_handler.handle_name_option
  when 'c'
    @dinodex_handler.handle_chain_option
  when 'r'
    @dinodex_handler.handle_reset_option
  when 'p'
    @dinodex_handler.handle_print_option
  when 'q'
    exit
  end
end

main
