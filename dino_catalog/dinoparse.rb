require './dinosaur'

class DinoParse
  def self.new(files)
    raw_dinosaurs = read(files)
    clean_dinosaurs = standardize(raw_dinosaurs)
    convert_to_object(clean_dinosaurs)
  end

  def self.convert_to_object(dinosaurs)
    dinosaurs.map{ |dinosaur| Dinosaur.new(dinosaur) }
  end

  def self.standardize(dinosaurs)
    dinosaurs.map do |dinosaur|
      new_dino = {}
      new_dino[:genus] = dinosaur[:name] || dinosaur[:genus]
      new_dino[:weight] = dinosaur[:weight_in_lbs] || dinosaur[:weight]
      new_dino[:walking] = dinosaur[:walking]
      new_dino[:continent] = dinosaur[:continent]
      new_dino[:description] = dinosaur[:description]
      new_dino[:diet_details] = dinosaur[:diet]
      new_dino[:carnivore] = standardize_carnivore(dinosaur)
      new_dino[:periods] = dino_periods_processor(dinosaur[:period])
      new_dino
    end
  end

  def self.dino_periods_processor(periods)
    periods.split(" or ").map do |segment|
      temp = {}
      parts = segment.strip.split(" ")
      temp[:period] = parts.last
      if (parts.last != parts.first)
        temp[:modifier] = parts.first
      end
      temp
    end
  end

  def self.read(files)
    files.each_with_object([]) do |file, raw_dinosaurs|
      CSV.foreach(file, headers: true, header_converters: :downcase) do |row|
        raw_dinosaurs << symbolize_keys(row.to_hash)
      end
    end
  end

  private

  def self.standardize_carnivore(dinosaur)
    if dinosaur.include?(:carnivore)
      return dinosaur[:carnivore] == "Yes"
    else
      if dinosaur[:diet] == "Carnivore"
        return true
      else
        return false
      end
    end
  end

  def self.symbolize_keys(hash)
    result = {}
    hash.each do |key, value|
      result[key.to_sym] = value
    end
    result
  end
end
