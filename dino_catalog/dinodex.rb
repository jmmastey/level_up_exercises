require './dino'
require './dino_catalog'

@dino_catalog = DinoCatalog.new
@result_chain ||= []
@last_result = []

def main
  setup_chain

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
    handle_bipeds_option
  when '2'
    handle_carnivores_option
  when '3'
    handle_period_option
  when '4'
    handle_size_option
  when '5'
    handle_name_option
  when 'c'
    handle_chain_option
  when 'r'
    handle_reset_option
  when 'p'
    handle_print_option
  when 'q'
    exit
  end
end

def handle_bipeds_option
  bipeds = DinoCatalog.new(@dino_catalog.get_bipeds) & @result_chain
  bipeds.each { |dino| puts dino.name }

  @last_result = bipeds
end

def handle_carnivores_option
  carnivores = DinoCatalog.new(@dino_catalog.get_carnivores) & @result_chain
  carnivores.each { |dino| puts dino.name }

  @last_result = carnivores
end

def handle_period_option
  print 'period: '
  period = gets.chomp
  puts ''

  period_dinos = DinoCatalog.new(@dino_catalog.get_by_period(period)) & @result_chain
  period_dinos.each { |dino| puts dino.name }
  @last_result = period_dinos
end

def handle_size_option
  print '(b)ig or (s)mall: '
  size = gets.chomp
  puts ''

  size_dinos = DinoCatalog.new(@dino_catalog.get_big) & @result_chain if size == 'b'
  size_dinos = DinoCatalog.new(@dino_catalog.get_small) & @result_chain if size == 's'

  size_dinos.each { |dino| puts dino.name }
  @last_result = size_dinos
end

def handle_name_option
  print 'enter: '
  name = gets.chomp
  puts ''

  name_dinos = DinoCatalog.new(@dino_catalog.get_by_name(name)) & @result_chain
  name_dinos.each { |dino| puts dino.name }
  @last_result = name_dinos
end

def handle_chain_option
  @result_chain &= @last_result unless @last_result.empty?
  puts 'chain updated'
end

def handle_reset_option
  setup_chain
  puts 'chain reset'
end

def handle_print_option
  DinoCatalog.print(@last_result)
end

def setup_chain
  @result_chain = @dino_catalog
end

main
