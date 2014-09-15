require "CSV"
require_relative "dinosaur"

class DinodexLoader
  ALT_COLUMN_HANDLING = {
    carnivore: :normalized_diet
  }

  ALT_COLUMN_NAMING = {
    genus: "name",
    carnivore: "diet",
    weight_in_lbs: "weight"
  }

  def find_csv_files(directory)
    csv_files = []
    Dir.entries(directory).select { |f| File.extname(f) == ".csv" }.each do |f|
      csv_files.push f
    end
    csv_files
  end

  def load_csv_file(file)
    raise("File #{file} not found") unless File.exist?(file)

    new_dinosaurs = []
    table = CSV.read(file, headers: true)
    read_row(new_dinosaurs, table)
    new_dinosaurs
  end

  private

  def read_row(new_dinosaurs, table)
    table.each do |row|
      attrs = row.to_hash.inject({}) do |aggregator, var|
        aggregator[rename_field(var[0])] = normalize_field(var[0], var[1])
        aggregator
      end
      new_dinosaurs << Dinosaur.new(attrs)
    end
  end

  def rename_field(file_column)
    ALT_COLUMN_NAMING[file_column.downcase.to_sym] || file_column.downcase
  end

  def normalize_field(file_column, file_value)
    return file_value unless ALT_COLUMN_HANDLING[file_column.downcase.to_sym]
    send(ALT_COLUMN_HANDLING[file_column.downcase.to_sym], file_value)
  end

  def normalized_diet(carnivore)
    carnivore.downcase == "yes" ? "Carnivore" : "Herbivore"
  end
end
