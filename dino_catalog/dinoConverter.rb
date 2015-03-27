class DinoConverter 
  require_relative 'dino'
  require 'CSV'

  # ...these methods could be a lot smaller, Ava

  def self.csv_file_to_dino_array(file)
    csv = CSV::parse(File.open(file, 'r') {|f| f.read })
    fields = csv.shift
    hash_array = csv.collect { |record| Hash[*fields.zip(record).flatten ] } 
    fixed_headers_array = hash_array.collect { |hash| 
      fix_pirate_hash(hash)
    }    
    dino_array = []
    fixed_headers_array.collect do |dino|
      dino_array << Dino.new(dino)
    end
    puts "procesed #{file.to_s} and found #{dino_array.count} records!"
    return dino_array
  end

  def self.csv_files_to_dino_array(files)
    return nil if files == []
    arrays = files.collect do |file|
      csv_file_to_dino_array(file)
    end
    dino_array = []
    arrays.each do |array|
      dino_array += array
    end
    return dino_array
  end

  def self.fix_pirate_hash(hash)
    if hash.keys.include? "Genus"
      mappings = 
      {
        "Genus" => "NAME", 
        "Period" => "PERIOD", 
        "Carnivore" => "DIET", 
        "Weight" => "WEIGHT_IN_LBS", 
        "Walking" => "WALKING"
      }
      fixed_h = Hash[hash.map {|k, v| [mappings[k], v] }]
      case fixed_h["DIET"]
      when "Yes"
        fixed_h["DIET"] = "Carnivore"
      else
        fixed_h["DIET"] = "Unknown"
      end
      return fixed_h
    else
      return hash
    end
  end
end
