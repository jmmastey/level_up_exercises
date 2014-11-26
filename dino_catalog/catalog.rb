class Catalog
  attr_reader :dinos

  def initialize(dinos)
    @dinos = dinos
  end

  def length
    dinos.length
  end

  def print_all
    style_heading('All The Dinos')
    puts dinos.map(&:to_s)
  end

  def print_bipeds
    style_heading('Bipeds')
    puts bipeds.map(&:to_s)
  end

  def print_meat_eaters
    style_heading('Meat eaters')
    puts carnivores.map(&:to_s)
  end

  def print_large
    style_heading('Large Dinosaurs')
    puts gigantics.map(&:to_s)
  end

  def print_from_period
    puts 'Which Period?'
    period = gets.downcase.strip
    style_heading('Period')
    puts from_period(period).map(&:to_s)
  end

  private

  def from_period(period_option)
    dinos.select { |d| d.period.eql?(period_option.capitalize) }
  end

  def gigantics
    dinos.select { |d| d.gigantic? }
  end

  def carnivores
    dinos.select { |d| d.eats_meat? }
  end

  def bipeds
    dinos.select { |d| d.biped? }
  end

  def style_heading(heading)
    puts "#{heading}".center(40, '-')
  end
end
