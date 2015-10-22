require_relative 'dinosaur_csv_deserializer'
require_relative 'dinosaur_operations'

class DinoDex
  def initialize
    african_dinosaurs = DinosaurCsvDeserializer.deserialize(
      'african_dinosaur_export.csv',
      &DinosaurCsvDeserializer::AFRICAN_CSV_DESERIALIZER)

    dinodex_dinosaurs = DinosaurCsvDeserializer.deserialize(
      'dinodex.csv',
      &DinosaurCsvDeserializer::DINODEX_CSV_DESERIALIZER)

    @dinosaurs = african_dinosaurs + dinodex_dinosaurs
  end

  def filter_and_print_facts(operations = DinosaurOperations.operations)
    dinosaurs = @dinosaurs.clone

    operations.call(dinosaurs) while dinosaurs.any?
    puts 'No dinosaurs fit your query.' if dinosaurs.empty?
  end
end

dd = DinoDex.new
dd.filter_and_print_facts
