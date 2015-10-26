require 'json'

class Dinoshow
  def self.print_usage
    puts "ruby dinocatalog.rb <options>"
    puts "Options are: "
    puts "-b         Sort to show only bipeds dinosaurs"
    puts "-c         Sort to show only carnivores dinosaurs"
    puts "--period period      Sort to show dinosaurs which lived during period"
    puts "-s         Sort to only show small dinosaurs"
    puts "-B         Sort to only show big dinosaurs"
    puts "--search pattern    Search for pattern in the database"
    puts "--help        Shows this usage/help message"
    puts "--json         Export results in JSON"
  end

  def self.valid_data?(data)
    return false if data.nil? || data == 'N/A' || data.empty?
    true
  end

  def self.print_text(dinosaurs)
    dinosaurs.each do |dino|
      puts "Name: " << dino.name if valid_data?(dino.name)
      puts "Period: " << dino.period if valid_data?(dino.period)
      puts "Continent: " << dino.continent if valid_data?(dino.continent)
      puts "Diet: " << dino.diet if valid_data?(dino.diet)
      puts "Weight: " << dino.weight if valid_data?(dino.weight)
      puts "Walking: " << dino.walking if valid_data?(dino.walking)
      puts "Description: " << dino.description if valid_data?(dino.description)
      puts "---"
    end
    puts "Showed #{dinosaurs.count} Dinos"
  end

  def self.print_json(dinosaurs)
    json_dinos = []
    dinosaurs.each do |dino|
      json_dinos_hash = { 'name' => dino.name,
                          'period' => dino.period,
                          'continent' => dino.continent,
                          'diet' => dino.diet,
                          'weight' => dino.weight,
                          'walking' => dino.walking,
                          'description' => dino.description }
      json_dinos.push(json_dinos_hash)
    end
    json_dinos.push('dino_count' => dinosaurs.count) if dinosaurs.count > 0
    puts JSON.generate(json_dinos)
  end
end
