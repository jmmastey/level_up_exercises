class ImportData
  CSVFILES = ['dinodex.csv', 'african_dinosaur_export.csv']

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
    attr = {}
    DINO_ATTRIBUTES.each do |attribute|
      method_to_use = "#{attribute}_transform"
      attr[attribute] = send(method_to_use, dino_info)
    end
    attr
  end

  def self.name_transform(dino_info)
    dino_info["NAME"] || dino_info["Genus"]
  end

  def self.period_transform(dino_info)
    dino_info["PERIOD"] || dino_info["Period"]
  end

  def self.continent_transform(dino_info)
    dino_info["CONTINENT"] || "Africa"
  end

  def self.diet_transform(dino_info)
    return dino_info["DIET"] unless dino_info["DIET"].nil?
    case dino_info["Carnivore"]
      when "Yes" then return "Carnivore"
      when "No"  then return "Herbivore"
    end
  end

  def self.weight_transform(dino_info)
    dino_info["WEIGHT_IN_LBS"] || dino_info["Weight"]
  end

  def self.walking_transform(dino_info)
    dino_info["WALKING"] || dino_info["Walking"]
  end

  def self.description_transform(dino_info)
    dino_info["DESCRIPTION"]
  end

  def self.read_csv_file(csv_file_path)
    table_from_csv = []
    CSV.foreach(csv_file_path, headers: true, converters: :all) do |csv_obj|
      table_from_csv << csv_obj.to_h
    end
    table_from_csv
  end
end
