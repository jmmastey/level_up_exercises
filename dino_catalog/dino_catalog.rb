require_relative "dino_normalizer.rb"

class DinoCatalog
  def initialize
    reset_data
  end

  def reset_data
    @dinos = []
    @dino_field_index = {}
  end

  def catalog_dino(dino)
    DinoNormalizer.normalize(dino)
    dino_addr = @dinos.size
    @dinos << dino
    dino.each { |field, value| index_dino_field(dino_addr, field, value) }
  end

  def all_dinos
    @dinos
  end

  def dinos_where(filters = {})
    dino_addrs = filters.map { |flt, val| dino_addrs_with(flt, val) }
    dinos_at dino_addrs.inject(&:&)
  end

  private

  def index_dino_field(dino_addr, field, value)
    @dino_field_index[field] ||= {}
    @dino_field_index[field][value] ||= []
    @dino_field_index[field][value] << dino_addr
  end

  def dino_addrs_with(field, value)
    @dino_field_index[field][value] || []
  end

  def dinos_at(addrs)
    @dinos.values_at(*addrs)
  end
end
