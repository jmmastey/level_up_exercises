require './dino.rb'
class DinoDex
  def initialize(dino)
    @dinos = dino
  end

  def filter_dinos(filter)
    @matching_dinos = @dinos
    filter.each do |k, v|
      next if v.to_s.empty?
      select_dinos_per_attribute(k, v)
    end
    @matching_dinos
  end

  def select_dinos_per_attribute(k, v)
    if k.to_s == "weight"
      @matching_dinos.select! { |i| (i.weight >= v.to_i) }
    else
      @matching_dinos.select! { |i| i.send(k).include?(v) }
    end
  end

  def get_all_values(key)
    @dinos.map { |i| i.send(key) }.uniq
  end
end
