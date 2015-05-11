require './dino_class.rb'
class DinoDex
  def initialize(dino)
    @dinos = dino
  end

  def filter_dinos(filter)
    matching_dinos = @dinos
    filter.each do |k, v|
      next if v.to_s.empty?
      if k.to_s == "weight"
        matching_dinos.select! { |i| (i.weight >= filter[:weight].to_i) }
      else
        matching_dinos.select! { |i| i.send(k).include?(v) }
      end
    end
    matching_dinos
  end

  def get_all_values(key)
    @dinos.map { |i| i.send(key) }.uniq
  end
end
