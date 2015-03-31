class DinoConverter 
  require_relative 'dino'
  require 'CSV'

  MAPPINGS = 
  {
  "Genus" => "NAME", 
  "Period" => "PERIOD", 
  "Carnivore" => "DIET", 
  "Weight" => "WEIGHT_IN_LBS", 
  "Walking" => "WALKING"
  }

  def self.csv_file_to_dino_array(file)
    csv = CSV::parse(File.open(file, 'r') {|f| f.read })
    fields = csv.shift
    hash_array = csv.map { |record| Hash[*fields.zip(record).flatten] }
    fixed_headers_array = hash_array.map { |hash| fix_pirate_hash(hash) }
    dino_array = []
    fixed_headers_array.each do |dino|
      dino_array << Dino.new(dino)
    end
    dino_array
  end

  def self.csv_files_to_dino_array(files)
    abort("No files given") if files == []
    arrays = files.map do |file|
      csv_file_to_dino_array(file)
    end
    dino_array = []
    arrays.each do |array|
      dino_array += array
    end
    dino_array
  end

  def self.fix_pirate_hash(hash)
    if hash.keys.include? "Genus"
      fixed_h = Hash[hash.map {|k, v| [MAPPINGS[k], v] }]
      case fixed_h["DIET"]
        when "Yes"
          fixed_h["DIET"] = "Carnivore"
        else
          fixed_h["DIET"] = "Unknown"
      end
      fixed_h
    else
      hash
    end
  end
end
