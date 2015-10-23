require_relative 'dinosaur_deserializer'
require_relative 'dinosaur_operations'

class DinoDex
  def initialize
    dinodex_dinosaurs = DinosaurDeserializer::CSV::deserialize('dinodex.csv')

    african_dinosaurs = DinosaurDeserializer::CSV::deserialize('african_dinosaur_export.csv',
                                                               :african)

    @dinosaurs = dinodex_dinosaurs + african_dinosaurs
  end

  def filter_and_print_facts(operations = DinosaurOperations.operations)
    dinosaurs = @dinosaurs.clone

    operations.call(dinosaurs) while dinosaurs.any?
    puts 'No dinosaurs fit your query.' if dinosaurs.empty?
  end
end

dd = DinoDex.new
dd.filter_and_print_facts
