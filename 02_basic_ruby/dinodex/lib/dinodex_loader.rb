require "CSV"
require_relative "dinosaur"

class DinodexLoader

  def self.find_csv_files(directory)
    csv_files = []
    Dir.entries(directory).select { |f| File.extname(f) == '.csv' }.each do |f|
      csv_files.push f
    end
    csv_files
  end

  def self.load_csv_file(file)
    newDinosaurs = []
    if !File.exists?(file)
      raise("File #{file} not found")
    end

    table = CSV.read(file, {headers: true})
    table.each do |row|
      dinosaur = Dinosaur.new

      row.fields.each_with_index do |field, index|
        parse_csv_field(dinosaur, field, table.headers[index].downcase)
      end
      newDinosaurs.push dinosaur
    end
    newDinosaurs
  end

  def self.parse_csv_field(dinosaur, field, column_name)
    if !field.nil?
      #TODO: change this to just a map? dinosaur.send(fieldLookup[field] +"=", value)
      if ["genus", "name"].include? column_name
        dinosaur.name = field
      elsif ["period"].include? column_name
        dinosaur.period = field
      elsif ["diet"].include? column_name
        dinosaur.diet = field
      elsif ["carnivore"].include? column_name
        dinosaur.diet = normalized_diet(field)
      elsif ["weight_in_lbs", "weight"].include? column_name
        dinosaur.weight = field
      elsif ["walking"].include? column_name
        dinosaur.walking = field
      elsif ["description"].include? column_name
        dinosaur.description = field
      elsif ["continent"].include? column_name
        dinosaur.continent = field
      end
    end
  end

  def self.normalized_diet(diet)
    diet.downcase == "yes" ? "Carnivore" : "Herbivore"
  end

end