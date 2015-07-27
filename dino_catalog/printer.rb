class Printer
  def self.print_fact_string(dinosaur)
    print_intro_string(dinosaur.name.capitalize, dinosaur.period.capitalize)
    print_continent_string(dinosaur.continent)
    print_weight_string(dinosaur.weight)
    print_walking_string(dinosaur.walking)
    print_diet_string(dinosaur)
    print_description_string(dinosaur.description)
    puts
  end

  def self.print_intro_string(name, period)
    puts "The #{name} was from the #{period} period."
  end

  def self.print_continent_string(continent)
    puts "It lived in #{continent.capitalize}." if continent
  end

  def self.print_walking_string(walking)
    puts "It was a #{walking.downcase}." if walking
  end

  def self.print_weight_string(weight)
    puts "It weighed #{weight} pounds!" if weight
  end

  def self.print_description_string(description)
    puts "Fun fact: #{description.capitalize}" if description
  end

  def self.print_diet_string(dinosaur)
    if dinosaur.diet
      puts "This dinosaur was a #{dinosaur.diet.downcase}."
    elsif dinosaur.carnivorous?
      puts "This dinosaur was a carnivore."
    else
      puts "This dinosaur was not a carnivore."
    end
  end

  def self.print_with_facts(dinosaurs)
    return print_no_dinosaurs_found if dinosaurs.empty?
    dinosaurs.each { |dino| print_fact_string(dino) }
  end

  def self.print_no_dinosaurs_found
    puts "No dinosaurs were found. Please modify your query and try again.\n"
  end

  def self.print_names(dinosaurs)
    if !dinosaurs.empty?
      dinosaurs.each { |dino| puts "#{dino.name.capitalize}" }
    else
      print_no_dinosaurs_found
    end
  end
end
