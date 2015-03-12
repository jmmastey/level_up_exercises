require './dino_catalog'

class DinodexHandler
  def initialize
    @result_chain ||= []
    @last_result = []
    @dino_catalog = DinoCatalog.new
  end

  def handle_bipeds_option
    bipeds = DinoCatalog.new(@dino_catalog.bipeds) & @result_chain
    bipeds.each { |dino| puts dino.name }

    @last_result = bipeds
  end

  def handle_carnivores_option
    carnivores = DinoCatalog.new(@dino_catalog.carnivores) & @result_chain
    carnivores.each { |dino| puts dino.name }

    @last_result = carnivores
  end

  def handle_period_option
    print 'period: '
    period = gets.chomp
    puts ''

    period_dinos = DinoCatalog.new(@dino_catalog.by_period(period)) & @result_chain
    period_dinos.each { |dino| puts dino.name }
    @last_result = period_dinos
  end

  def handle_size_option
    print '(b)ig or (s)mall: '
    size = gets.chomp
    puts ''

    size_dinos = DinoCatalog.new(@dino_catalog.big) & @result_chain if size == 'b'
    size_dinos = DinoCatalog.new(@dino_catalog.small) & @result_chain if size == 's'

    size_dinos.each { |dino| puts dino.name }
    @last_result = size_dinos
  end

  def handle_name_option
    print 'enter: '
    name = gets.chomp
    puts ''

    name_dinos = DinoCatalog.new(@dino_catalog.find_by_name(name)) & @result_chain
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
end

