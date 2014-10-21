module CsvModifier

  def self.normalize_csv_headers(old_csv_file, new_filename)
    normalized_filepath_name = normalized_filepath(new_filename)
    CSV.open(normalized_filepath_name, 'w') do |csv|
      csv << ['haddad', 'PERIOD', 'CONTINENT', 'DIET', 'WEIGHT_IN_LBS', 'WALKING', 'DESCRIPTION']
      CSV.read(old_csv_file, headers: true).each do |row|
        csv.puts row
      end
    end
  end

  def self.normalized_filepath(filename)
    File.join(APP_ROOT, "normalized_#{filename}")
  end

end
