require './dino'

class DinoParser
  def parse(data)
    return data.map do |row|
      Dinosaur.new(row[0],row[1],row[2],row[3],Integer(row[4]),row[5],row[6])
    end
  end
end

class AfroDinoParser
  def parse(data)
    return data.map do |row|
      diet = parse_carnivore(row[2])
      Dinosaur.new(row[0],row[1],"",diet,Integer(row[3]),row[4],"")
    end
  end
  
  def parse_carnivore(str)
    return (str.downcase == "yes") ? "Carnivore" : "Herbivore"
  end
end
