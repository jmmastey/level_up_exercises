module CsvModifier

  @@alias_table = {
    'Genus' => 'Name',
    'Carnivore' => 'Diet',
    'Weight' => 'Weight_in_lbs'
  }

  def normalize_csv_headers(old_csv_file)
    new_headers = replace_header_with_alias(old_csv_file)
    CSV.open("normalized_csv_file.csv", 'w') do |csv|
      csv << new_headers
      CSV.read(old_csv_file, headers: true).each do |row|
        row['Carnivore'] = 'Carnivore' if row['Carnivore'] == 'Yes'
        row['Carnivore'] = nil if row['Carnivore'] == 'No'
        csv.puts row
      end
    end
  end

  def replace_header_with_alias(csv_file)
    header_row = CSV.read(csv_file, headers: true).headers
    new_header_row = []
    header_row.each do |column_name|
      if @@alias_table[column_name]
        new_header_row << @@alias_table[column_name]
      else
        new_header_row << column_name
      end
    end
    new_header_row
  end

end
