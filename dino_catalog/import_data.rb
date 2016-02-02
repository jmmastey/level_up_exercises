class ImportData
  CSVFILES = ['dinodex.csv', 'african_dinosaur_export.csv']
  NORMALIZE_MAPPINGS = { genus: "name", carnivore: "carnivore",
                         weight_in_lbs: "weight" }

  def self.load_and_transform
    processed_data = []
    CSVFILES.each do |file_path|
      (read_csv_file(file_path)).each do |dino_info|
        processed_data << transform(dino_info)
      end
    end
    processed_data
  end

  def self.transform(dino_info)
    normalized_info = {}
    dino_info.each do |k, v|
      normalized_info.merge!(normalize(k, v))
    end
    add_default_values(normalized_info)
  end

  def self.add_default_values(normalized_info)
    normalized_info[:continent] = normalized_info.fetch(:continent, "Africa")
    normalized_info
  end

  def self.normalize(key, value)
    return { key => value } unless NORMALIZE_MAPPINGS.key?(key)
    method_to_use = "#{NORMALIZE_MAPPINGS[key]}_transform"
    send(method_to_use, value)
  end

  def self.name_transform(value)
    { name: value }
  end

  def self.carnivore_transform(value)
    diet = value == "Yes" ? "Carnivore" : "Herbivore"
    { diet: diet }
  end

  def self.weight_transform(value)
    { weight: value }
  end

  def self.read_csv_file(csv_file_path)
    table_from_csv = []
    csv_params = { headers: true, converters: :all, header_converters: :symbol }
    CSV.foreach(csv_file_path, csv_params) do |csv_obj|
      table_from_csv << csv_obj.to_h
    end
    table_from_csv
  end
end
