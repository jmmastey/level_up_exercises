class Dinosaur
  TWO_TONS = 4000

  attr_accessor :data

  def initialize(data = {})
    @data = data
  end

  def has?(key)
    data.has_key?(key)
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

  def size_is?(size)
    size = size.downcase
    return false if data['weight'].length == 0
    return Float(data['weight']) > TWO_TONS if size == 'big'
    return Float(data['weight']) < 2000 if size == 'small'
    return data['weight'] == size
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
