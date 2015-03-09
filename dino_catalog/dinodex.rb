require './dinodex_handler'

def main
  DinodexHandler.setup_chain

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
    DinodexHandler.handle_bipeds_option
  when '2'
    DinodexHandler.handle_carnivores_option
  when '3'
    DinodexHandler.handle_period_option
  when '4'
    DinodexHandler.handle_size_option
  when '5'
    DinodexHandler.handle_name_option
  when 'c'
    DinodexHandler.handle_chain_option
  when 'r'
    DinodexHandler.handle_reset_option
  when 'p'
    DinodexHandler.handle_print_option
  when 'q'
    exit
  end
end

main
