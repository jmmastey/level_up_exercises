class ImportData
  CSVFILES = ['dinodex.csv', 'african_dinosaur_export.csv'].freeze

  def self.load_and_transform
    processed_data = []
    CSVFILES.each do |file_path|
      read_csv_file(file_path).each do |dino_info|
        processed_data << TransformData.transform(dino_info)
      end
    end
    processed_data
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
