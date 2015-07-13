class DinoCatalog
  attr_accessor :dino_data

  def initialize(dinodata = [])
    @dino_data = dinodata
  end

  def populate_data
    dl = DinoLoader.new
    data = dl.load_dino_data
    data.each { |x| @dino_data << Dinosaur.new(x) }
  end

  def show_data
    @dino_data.each { |dino| dino }
  end

  def add_to_catalog(data)
    @dino_data << data
  end

  def search_by_trait(trait, criteria = nil)
    trait = trait.downcase
    criteria = criteria.downcase unless criteria.nil?
    filter_data = @dino_data.select do |dino|
      next if dino.public_send(trait).nil? || dino.public_send(trait).empty?
      filter_by_criteria(dino.public_send(trait), criteria)
    end
    DinoCatalog.new(filter_data)
  end

  def filter_by_criteria(dino, criteria)
    if criteria.nil?
      dino.downcase
    else
      dino.downcase.include?(criteria)
    end
  end

  def search_by_size(size)
    filter_data = @dino_data.select { |dino| dino.public_send("#{size}?") }
    DinoCatalog.new(filter_data)
  end

  def to_s
    @dino_data.each_with_object("") { |dino, value| value << "#{dino}\n" }
  end
end
