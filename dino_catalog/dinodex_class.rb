require './dino_class.rb'
class DinoDex
  def initialize(dino_arry)
    @dino_array = dino_arry
  end

  def filter_dinos(filter)
    matching_dinos = @dino_array
    filter.each do |k, v|
      next if v == ""
      if k.to_s == "weight"
        matching_dinos.select! { |i| (i.weight >= filter[:weight].to_i) }
      else
        matching_dinos.select! { |i| i.send(k).include? v }
      end
    end
    matching_dinos
  end

  def get_all_values(key)
    values = Array[]
    @dino_array.each do |i|
      values << i.send(key)
    end
    values.uniq
  end
end
