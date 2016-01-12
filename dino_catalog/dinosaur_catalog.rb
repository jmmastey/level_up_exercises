require "CSV"

class DinosaurCatalog
  attr_accessor :files
  attr_accessor :catalogs

  def initialize(attrs = {})
    @catalogs = []
    @files = Array(attrs[:catalogs])
    read_catalogs
  end

  def read_catalogs
    @files.map do |file_name|
      @catalogs << CSV.read(
        file_name,
        headers: true,
        header_converters: :symbol,
      )
    end
  end

  def find_dinos(key, value)
    results = []
    @catalogs.map do |catalog|
      results.concat catalog.select { |dino|
        dino[key] == value
      }
    end
    results
  end

  def find_large_dinosaurs
    results = []
    @catalogs.map do |catalog|
      results.concat catalog.select { |dino|
        dino[:weight] > 2000 || dino[:weight_in_lbs] > 2000
      }
    end
    results
  end

  def find_small_dinosaurs
    results = []
    @catalogs.map do |catalog|
      results.concat catalog.select { |dino|
        dino[:weight] <= 2000 || dino[:weight_in_lbs] <= 2000
      }
    end
    results
  end

  def find_bipeds
    find_dinos(:walking, "Biped")
  end

  def find_carnivores
    results = find_dinos(:diet, "Carnivore")
    results.concat find_dinos(:diet, "Insectivore")
    results.concat find_dinos(:diet, "Piscivore")
    results.concat find_dinos(:carnivore, "Yes")
    results
  end

  def find_by_period(time_period)
    find_dinos(:period, time_period)
  end

  def retrieve_dinosaur_facts
  end
end
