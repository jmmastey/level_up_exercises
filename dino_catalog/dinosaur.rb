class Dinosaur
  TWO_TONS = 4000

  attr_accessor :data

  def initialize(data = {})
    @data = data
  end

  def has?(key)
    data.key?(key)
  end

  def name_is?(name)
    data['name'].downcase == name.downcase
  end

  def from_period?(period)
    data['period'].downcase.include?(period.downcase)
  end

  def diet_is?(diet)
    return carnivore? if diet.downcase == 'carnivore'
    data['diet'].downcase == diet.downcase
  end

  def carnivore?
    data['diet'].downcase != 'herbivore'
  end

  def big?
    return false unless has?('weight')
    Float(data['weight']) > TWO_TONS
  end

  def small?
    return false unless has?('weight')
    !big?
  end

  def weight_is?(weight)
    return false unless has?('weight')
    Float(data['weight']) == Float(weight)
  end

  def walking_is?(walking)
    data['walking'].downcase == walking.downcase
  end

  def to_s
    max_len = data.keys.max_by(&:length).length
    data.each do |dino_attr, value|
      spaces = ' ' * (max_len - dino_attr.length)
      puts "#{dino_attr}: #{spaces} #{value}"
    end
  end
end
