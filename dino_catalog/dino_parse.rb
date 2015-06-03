# This class is used to define the parsing for the dinosaur class
class DinoParse
  NAME_CONVERTER = lambda do |field|
    field = 'NAME' if field == 'Genus'
    field
  end

  DIET_CONVERTER = lambda do |field|
    field = 'DIET' if field == 'Carnivore'
    field
  end

  WEIGHT_CONVERTER = lambda do |field|
    field = 'WEIGHT_IN_LBS' if field == 'Weight'
    field
  end

  CONVERTERS = [DIET_CONVERTER, WEIGHT_CONVERTER, NAME_CONVERTER, :downcase]

  def parse_csv(csv)
    @dinosaurs = []
    CSV.foreach(csv,
                headers: true,
                header_converters: CONVERTERS)do |row|
      a = Dinosaur.new(row.to_hash)
      @dinosaurs << a
    end
    @dinosaurs
  end
end
