require 'json'

class Export
  EXPORT_FILENAME = "dino_catalog_export.json"

  def self.convert_to_json(catalog)
    temp = convert_to_hash(catalog)
    File.open(EXPORT_FILENAME, "w") do |f|
      f.puts JSON.generate(temp)
      puts "Dino Stored exported to file "
    end
  end

  def self.convert_to_hash(catalog)
    temp = []
    catalog.each { |row| temp << row.to_hash }
    temp
  end
end
