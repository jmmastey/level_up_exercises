require './dino'
require 'csv'

module DinoParser
  def self.parse_dinos_from_csv(filename = 'dinodex.csv')
    if !File.exist?(filename)
      raise ArgumentError, "couldnt find #{filename}"
    end
  
    rows = CSV.read(filename)
    headers = rows.shift
    csv_type = determine_csv_type(headers)

    #assuming that csv formats for dinos come in specific flavors
    case csv_type
    when "african"
      return parse_african_csv(filename)
    when "standard"
      return parse_standard_csv(filename)
    else
      raise ArgumentError, "cannot determine csv type"
    end
  end

  STANDARD_CSV_HEADERS = %w[NAME PERIOD CONTINENT DIET WEIGHT_IN_LBS WALKING DESCRIPTION].sort
  AFRICAN_CSV_HEADERS = %w[Genus Period Carnivore Weight Walking].sort

  #look for exact header names, but order doesn't matter
  def self.determine_csv_type(headers)
    sorted_headers = headers.sort
    return "standard" if sorted_headers == STANDARD_CSV_HEADERS
    return "african"  if sorted_headers == AFRICAN_CSV_HEADERS
    return "unknown"
  end

  def self.parse_african_csv(filename)
    dinos = []
    CSV.foreach(filename, headers: true) do |row|
      name =        row['Genus']
      period =      row['Period']
      diet =        set_custom_diet(row['Carnivore'])
      weight =      row['Weight']
      walking =     row['Walking']
    
      dinos << Dino.new(name: name,
                        period: period,
                        diet: diet,
                        weight: weight.to_i,
                        walking: walking)
    end
    dinos
  end

  def self.parse_standard_csv(filename)
    dinos = []
    CSV.foreach(filename, headers: true) do |row|
      name =        row['NAME']
      period =      row['PERIOD']
      continent =   row['CONTINENT']
      diet =        row['DIET']
      weight =      row['WEIGHT_IN_LBS']
      walking =     row['WALKING']
      description = row['DESCRIPTION']
    
      dinos << Dino.new(name: name,
                        period: period,
                        continent: continent,
                        diet: diet,
                        weight: weight.to_i,
                        walking: walking,
                        description: description)
    end
    dinos
  end

  def self.set_custom_diet(is_carnivore)
    if is_carnivore == "Yes" 
      "Carnivore"
    elsif is_carnivore == "No"
      "Herbivore"
    else
      nil
    end
  end
end
