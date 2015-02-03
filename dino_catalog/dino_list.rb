require_relative 'dinosaur'

class DinoList < Array

  def is_pirate_list
    @is_pirate_list
  end

  def is_pirate_list=(is_pirate_table)
    @is_pirate_list = is_pirate_table
  end

  def get_big
    self.select!{ |dino| dino.weight.to_i > 4000}
  end

  def get_small
    self.select!{ |dino| dino.weight != nil && dino.weight.to_i <= 4000}
  end

  def get_bipeds
    self.select!{ |dino| dino.walking.downcase == 'biped'}
  end

  def get_from_period period_name
    self.select!{ |dino| dino.period.downcase.include? period_name}
  end

  def get_carnivores
    self.select!{ |dino| dino.diet.downcase != 'herbivore'}
  end

  def get_by_name name
    self.select!{ |dino| dino.name.downcase == name}
  end

  def pretty_print
    print_weight = self.select{ |dino| dino.weight != nil}.any? ? true : false
    print_desc = self.select{ |dino| dino.description != nil}.any? ? true : false

    table = Terminal::Table.new do |t|
      t << set_headers(print_weight, print_desc)
      t << :separator
      self.each do |dino|
        t << prettify_dino(dino, print_weight, print_desc)
      end
    end

    table
  end 

  def prettify_dino dino, print_weight, print_desc
    if @is_pirate_list
      arr = [dino.name, dino.period, dino.diet]
      arr << dino.weight if print_weight
      arr << dino.walking
      arr
    else      
      arr = [dino.name, dino.period, dino.continent, dino.diet]
      arr << dino.weight if print_weight
      arr << dino.walking
      arr << dino.description if print_desc
      arr
    end
  end

  def set_headers print_weight, print_desc
    headers = ['Name', 'Period']
    headers << 'Continent' unless @is_pirate_list
    headers << 'Diet'
    headers << 'Weight' unless !print_weight
    headers << 'Walking'
    headers << 'Description' unless @is_pirate_list || !print_desc
    headers
  end
end