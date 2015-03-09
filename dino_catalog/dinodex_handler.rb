require './dino_catalog'

class DinodexHandler
  @result_chain ||= []
  @last_result = []
  @dino_catalog = DinoCatalog.new

  def self.handle_bipeds_option
    bipeds = DinoCatalog.new(@dino_catalog.get_bipeds) & @result_chain
    bipeds.each { |dino| puts dino.name }

    @last_result = bipeds
  end

  def self.handle_carnivores_option
    carnivores = DinoCatalog.new(@dino_catalog.get_carnivores) & @result_chain
    carnivores.each { |dino| puts dino.name }

    @last_result = carnivores
  end

  def self.handle_period_option
    print 'period: '
    period = gets.chomp
    puts ''

    period_dinos = DinoCatalog.new(@dino_catalog.get_by_period(period)) & @result_chain
    period_dinos.each { |dino| puts dino.name }
    @last_result = period_dinos
  end

  def self.handle_size_option
    print '(b)ig or (s)mall: '
    size = gets.chomp
    puts ''

    size_dinos = DinoCatalog.new(@dino_catalog.get_big) & @result_chain if size == 'b'
    size_dinos = DinoCatalog.new(@dino_catalog.get_small) & @result_chain if size == 's'

    size_dinos.each { |dino| puts dino.name }
    @last_result = size_dinos
  end

  def self.handle_name_option
    print 'enter: '
    name = gets.chomp
    puts ''

    name_dinos = DinoCatalog.new(@dino_catalog.get_by_name(name)) & @result_chain
    name_dinos.each { |dino| puts dino.name }
    @last_result = name_dinos
  end

  def self.handle_chain_option
    @result_chain &= @last_result unless @last_result.empty?
    puts 'chain updated'
  end

  def self.handle_reset_option
    setup_chain
    puts 'chain reset'
  end

  def self.handle_print_option
    DinoCatalog.print(@last_result)
  end

  def self.setup_chain
    @result_chain = @dino_catalog
  end
end

