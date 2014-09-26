# Sample headers: Genus,Period,Carnivore,Weight,Walking
# Sample content: Melanorosaurus,Triassic,No,2400,Quadruped

class AfricanFile < FileHandler
  def get_all_dinosaurs()
    dinosaurs = []

    #loop through content
    contents.each do |content|
      dinosaurs << map_to_dinosaur(content)
    end

    dinosaurs
  end

  def map_to_dinosaur(content)
    dinosaur = Dinosaur.new()

    #map headers to content
    headers.zip(content).each do |field, value|
      case field.downcase
        when 'genus'
          dinosaur.name = value
        when 'carnivore'
          dinosaur.diet = value
        else
          dinosaur.send("#{field.downcase}=", value)
      end
    end

    #dinosaur
    dinosaur.name
  end
end