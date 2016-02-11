class DinoDex
  attr_reader :all_dinosaurs

  def initialize(dino_list)
    @all_dinosaurs = dino_list
  end

  def find_by_name(search_name)
    all_dinosaurs.select { |dino| dino.name.casecmp(search_name) == 0 }
  end

  def filter_by_hash(filters)
    all_dinosaurs.select do |dino|
      filters.each { |k, v| break unless dino.send(k) =~ /#{v}/i }
    end
  end
end
