require "CSV"
require_relative "dinosaur"

class DinodexLoader
  ALT_COLUMN_HANDLING = {
      genus: "name",
      carnivore: {field: "diet", processor: :normalized_diet},
      weight_in_lbs: "weight"
  }

  def find_csv_files(directory)
    csv_files = []
    Dir.entries(directory).select { |f| File.extname(f) == '.csv' }.each do |f|
      csv_files.push f
    end
    csv_files
  end

  def load_csv_file(file)
    raise("File #{file} not found") unless File.exists?(file)

    newDinosaurs = []
    table = CSV.read(file, {headers: true})
    table.each do |row|
      dinosaur = Dinosaur.new

      row.fields.each_with_index do |field, index|
        parse_csv_field(dinosaur, field, table.headers[index].downcase)
      end
      newDinosaurs.push dinosaur
    end
    newDinosaurs
  end

  private

  def parse_csv_field(dinosaur, value, column_name)
    field_name = ALT_COLUMN_HANDLING[column_name.to_sym] || column_name
    if field_name.is_a?(Hash) && self.respond_to?(field_name[:processor], true)
      value = self.send(field_name[:processor], value)
      field_name = field_name[:field]
    end
    dinosaur.send("#{field_name}=", value) if dinosaur.respond_to? ("#{field_name}=")
  end

  def normalized_diet(carnivore)
    carnivore.downcase == "yes" ? "Carnivore" : "Herbivore"
  end

end