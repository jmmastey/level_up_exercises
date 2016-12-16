class DinoDex
  require 'csv'
  require_relative 'dinosaur'

  def initialize
    @dinosaurs = create_dinosaurs
  end

  def all_dinosaurs
    @dinosaurs
  end

  def find_by_name(search_string)
    @dinosaurs.select { |dino| dino.name =~ /^#{search_string}$/i }
  end

  def filter_by_hash(search_hash)
    @dinosaurs.select do |dino|
      search_hash.each { |k,v| break if !(dino.send(k) =~ /#{v}/i) }
    end
  end

  private

  def create_dinosaurs
    dino_array = []
    Dir.glob('*.csv').each do |file|
      table = CSV.read(file, headers: true, header_converters: :symbol,
                       converters: :all)
      table.each do |dino|
        dino_array << Dinosaur.new(formatted_data(dino))
      end
    end
    dino_array
  end

  def formatted_data(dino)
    {
      name:        dino[:name] || dino[:genus],
      period:      correct_period(dino[:period]),
      continent:   dino.fetch(:continent, "Africa"),
      diet:        correct_diet(dino),
      weight:      dino[:weight_in_lbs] || dino[:weight],
      size:        small_or_large(dino),
      walking:     dino[:walking],
      description: dino[:description]
    }
  end

  def correct_diet(dino)
    if dino[:carnivore]
      fix_carnivore(dino)
    elsif dino[:diet] =~ /(Piscivore)|(Insectivore)/
      "Carnivore > #{dino[:diet]}"
    else
      dino[:diet]
    end
  end

  def fix_carnivore(dino)
    dino[:carnivore].downcase == 'yes' ? 'Carnivore' : nil
  end

  def correct_period(dino_period)
    case dino_period
    when /Oxfordian/
      "Late Jurassic > Oxfordian"
    when /Albian/
      "Early Cretaceous > Albian"
    else
      dino_period
    end
  end

  def small_or_large(dino)
    weight = dino[:weight_in_lbs] || dino[:weight]
    unless weight.nil?
      weight > 2000 ? "Large" : "Small"
    end
  end
end
