class Dinosaur
  TWO_TONS = 4000
  SMALL = 2000

  attr_accessor :data

  def initialize(data = {})
    @data = data
  end

  def has?(key)
    data.key?(key)
  end

  def name_is?(name)
    data['name'] == name
  end

  def from_period?(period)
    data['period'].include?(period)
  end

  def diet_is?(diet)
    return carnivore? if diet == 'carnivore'
    data['diet'] == diet
  end

  def carnivore?
    data['diet'] != 'herbivore' && data['diet'] != ""
  end

  def big?(b)
    return unless data['weight']
    b == (Float(data['weight']) > TWO_TONS)
  end

  def small?(b)
    return unless data['weight']
    b == (Float(data['weight']) < SMALL)
  end

  def weight_is?(weight)
    data['weight'] == weight
  end

  def walking_is?(walking)
    data['walking'] == walking.downcase
  end

  def to_s
    max_len = data.keys.max_by(&:length).length
    data.each do |k, v|
      spaces = ' ' * (max_len - k.length)
      puts "#{k}: #{spaces} #{v}"
    end
  end
end
