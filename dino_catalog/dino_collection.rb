class DinoCollection
  attr_accessor :dinos

  def initialize(array_of_dinos = nil)
    @dinos = []
    load(array_of_dinos) unless array_of_dinos.nil?
  end

  def load(array_of_dinos)
    array_of_dinos.each { |attrs| create_dino(attrs) }
  end

  def create_dino(attrs)
    dinos << Dino.new(attrs)
  end

  def <<(dino)
    add_dino(dino)
  end

  def add_dino(dino)
    dinos << dino
  end

  def to_s
    to_json
  end

  def to_json
    array_of_hashes = []
    dinos.each do |dino|
      array_of_hashes << dino.to_hash
    end
    JSON.pretty_generate(array_of_hashes)
  end
end
