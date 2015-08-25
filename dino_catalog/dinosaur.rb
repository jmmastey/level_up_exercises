class Dinosaur
  TWO_TONS = 4000

  attr_accessor :data

  def initialize(data = {})
    @data = data
  end

  def has?(key)
    data.key?(key)
  end

  def named?(name)
    data['name'].strip.downcase == name.downcase
  end

  def period?(period)
    data['period'].strip.downcase.include?(period.downcase)
  end

  def diet?(diet)
    return carnivore? if diet.downcase == 'carnivore'
    data['diet'].strip.downcase == diet.downcase
  end

  def carnivore?
    data['diet'].strip.downcase != 'herbivore'
  end

  def big?
    return false unless has?('weight')
    Float(data['weight']) > TWO_TONS
  end

  def small?
    return false unless has?('weight')
    !big?
  end

  def weighs?(weight)
    return false unless has?('weight')
    Float(data['weight']) == Float(weight)
  end

  def walking?(walking)
    data['walking'].strip.downcase == walking.downcase
  end

  def to_s
    max_len = data.keys.max_by(&:length).length
    data.each do |dino_attr, value|
      spaces = ' ' * (max_len - dino_attr.length)
      puts "#{dino_attr}: #{spaces} #{value}"
    end
  end
end
