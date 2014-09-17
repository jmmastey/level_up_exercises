require 'csv'
require './dinosaur'
require './details'
require './alert'

module DinosaurCSVParser

  # Normalized Headers
  NORM_HEADERS = {

    # File-Type I
    "NAME"          => "Name",
    "PERIOD"        => "Period",
    "CONTINENT"     => "Continent",
    "DIET"          => "Diet",
    "WEIGHT_IN_LBS" => "Weight",
    "WALKING"       => "Walking",
    "DESCRIPTION"   => "Description",

    # File-Type II
    "Genus"     => "Name",
    "Period"    => "Period",
    "Carnivore" => "Diet",
    "Weight"    => "Weight",
    "Walking"   => "Walking",
  }

  # Normalized Values
  NORM_VALUES = {
    ["Diet", "Yes"] => "Carnivore",
    ["Diet", "No" ] => "Herbivore",
  }

  def DinosaurCSVParser.is_valid_file? filename
    File.exist?(filename) && File.file?(filename)
  end

  def DinosaurCSVParser.is_valid_value? value
    !value.nil? && !value.empty?
  end

  def DinosaurCSVParser.parse(filename)
    Details["Parsing: " + filename]
    Alert.exit "File does not exist: " + filename unless is_valid_file?(filename)
    rows = CSV.read(filename, headers:true);
    dinosaurs = rows.map { |row| parse_row(row) }
  end


  def DinosaurCSVParser.parse_row(row)
    normalized = normalize(row)
    build(normalized)
  end

  def DinosaurCSVParser.normalize(row)
    normalized = {}
    row.to_hash.each do |key, value|
      key, value = normalize_attribute(key, value)
      normalized[key] = value
    end
    normalized
  end

  def DinosaurCSVParser.normalize_attribute(key, value)
    key = replace_key(key)
    value = replace_value(key, value)
    return key, value
  end

  def DinosaurCSVParser.replace_key(key)
    key = NORM_HEADERS[key] if NORM_HEADERS.has_key?(key)  
    key
  end

  def DinosaurCSVParser.replace_value(key, value)
    element = [key, value || ""]
    value = NORM_VALUES[element] if NORM_VALUES.has_key?(element)
    value
  end

  def DinosaurCSVParser.build(normalized)
    dinosaur = Dinosaur.new
    dinosaur.name        = normalized["Name"       ] if is_valid_value?(normalized["Name"       ])
    dinosaur.period      = normalized["Period"     ] if is_valid_value?(normalized["Period"     ])
    dinosaur.continent   = normalized["Continent"  ] if is_valid_value?(normalized["Continent"  ])
    dinosaur.diet        = normalized["Diet"       ] if is_valid_value?(normalized["Diet"       ])
    dinosaur.weight      = normalized["Weight"     ] if is_valid_value?(normalized["Weight"     ])
    dinosaur.walking     = normalized["Walking"    ] if is_valid_value?(normalized["Walking"    ])
    dinosaur.description = normalized["Description"] if is_valid_value?(normalized["Description"])
    dinosaur
  end

end
