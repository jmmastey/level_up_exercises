class AfricanFile < FileHandler
  def get_all_dinosaurs()
    dinosaurs = []

    #loop through content
    contents.each do |content|
      #dinosaurs << map_to_dinosaur(content)
      dinosaurs << content
    end

    puts dinosaurs
  end

  def map_to_dinosaur(content)
    dinosaur = new Dinosaur()

    #map headers to content
    headers.zip(content).each do |field, value|
      dinosaur.field = value
    end
  end
end