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
    standardized = []
    dinosaurs.each do |dinosaur|
      temp = {}
      temp[:genus] = dinosaur[:name] || dinosaur[:genus]
      temp[:weight] = dinosaur[:weight_in_lbs] || dinosaur[:weight]
      temp[:walking] = dinosaur[:walking]
      temp[:continent] = dinosaur[:continent]
      temp[:description] = dinosaur[:description]
      temp[:diet_details] = dinosaur[:diet]
      temp[:carnivore] = dinosaur[:carnivore] ||
                        (dinosaur[:diet] == "Carnivore" ? "Yes" : "No")
      temp[:periods] = dino_periods_processor(dinosaur[:period])
      standardized << temp
    end
    standardized
  end

  def self.dino_periods_processor(periods)
    results = []
    periods.split(" or ").each do |segment|
      temp = {}
      parts = segment.strip.split(" ")
      temp[:period] = parts.last
      if (parts.last != parts.first)
        temp[:modifier] = parts.first
      end
      results << temp
    end
    results
  end

  def self.read(files)
    raw_dinosaurs = []
    files.each do |file|
      CSV.foreach(file, headers: true, header_converters: :downcase) do |row|
        raw_dinosaurs << row.to_hash.symbolize_keys
      end
    end
    raw_dinosaurs
  end
end
