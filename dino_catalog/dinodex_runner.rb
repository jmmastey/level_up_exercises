require './dino_parser'

class DinodexRunner
  #todo: filter, attr, value, comparator
  def initialize(files = ['dinodex.csv', 'african_dinosaur_export.csv'])
    @result_chain ||= []
    @last_result = []
    @dino_catalog = DinoCatalog.new
    DinoParser.parse(files, @dino_catalog)
    setup_chain
  end

  def handle_bipeds_option
    bipeds = @result_chain.bipeds
    bipeds.each { |dino| puts dino.name }

    @last_result = bipeds
  end

  def handle_carnivores_option
    carnivores = @result_chain.carnivores
    carnivores.each { |dino| puts dino.name }

    @last_result = carnivores
  end

  def handle_period_option
    print 'period: '
    period = gets.chomp
    puts ''

    period_dinos = @result_chain.by_period(period)
    period_dinos.each { |dino| puts dino.name }
    @last_result = period_dinos
  end

  def handle_size_option
    print '(b)ig or (s)mall: '
    size = gets.chomp
    puts ''

    size_dinos = @result_chain.big if size == 'b'
    size_dinos = @result_chain.small if size == 's'

    size_dinos.each { |dino| puts dino.name }
    @last_result = size_dinos
  end

  def handle_name_option
    print 'enter: '
    name = gets.chomp
    puts ''

    name_dinos = @result_chain.find_by_name(name)
    name_dinos.each { |dino| puts dino.name }
    @last_result = name_dinos
  end

  def handle_chain_option
    @result_chain = @last_result unless @last_result.empty?
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

