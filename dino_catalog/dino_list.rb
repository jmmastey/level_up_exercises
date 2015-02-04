require_relative 'dinosaur'
class DinoList < Array
  attr_accessor :is_pirate_list

  def get_big
    select! { |dino| dino.weight.to_i > 4000 }
  end

  def get_small
    select! { |dino| dino.weight && dino.weight.to_i <= 4000 }
  end

  def get_bipeds
    select! { |dino| dino.walking.downcase == 'biped' }
  end

  def get_from_period(period_name)
    select! { |dino| dino.period.downcase.include? period_name.downcase }
  end

  def get_carnivores
    select! { |dino| dino.diet.downcase != 'herbivore' }
  end

  def get_by_name(name)
    select! { |dino| dino.name.downcase == name }
  end

  def pretty_print
    if !any?
      puts "#########     No Dinos Left to Display - Hit (R) to Reset Filters      #########"
      return
    end

    print_weight = select { |dino| dino.weight }.any?
    print_desc = select { |dino| dino.description }.any?

    Terminal::Table.new do |t|
      t << set_headers(print_weight, print_desc)
      t << :separator
      each do |dino|
        t << prettify_dino(dino, print_weight, print_desc)
      end
    end
  end

  def set_headers(print_weight, print_desc)
    headers = ['Name', 'Period']
    headers << 'Continent' unless is_pirate_list
    headers << 'Diet'
    headers << 'Weight' unless !print_weight
    headers << 'Walking'
    headers << 'Description' unless is_pirate_list || !print_desc
    headers
  end

  def prettify_dino(dino, print_weight, print_desc)
    if is_pirate_list
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

  def to_json
    puts map { |dino| dino.to_json }
  end

  def load_csv(csv)
    CSV.foreach(csv, headers: true) do |row|
      self.is_pirate_list |= !row.header?('DESCRIPTION')

      new_dino = Dinosaur.new
      new_dino.name = row['Genus'] || row['NAME']
      new_dino.period = row['Period'] || row['PERIOD']
      new_dino.continent = row['CONTINENT']
      new_dino.diet = extract_diet(row)
      new_dino.weight = row['Weight'] || row['WEIGHT_IN_LBS']
      new_dino.walking = row['Walking'] || row['WALKING']
      new_dino.description = row['DESCRIPTION']

      push(new_dino)
    end
  end

  def extract_diet(row)
    row['DIET'] || (row['Carnivore'] == 'Yes' ? 'Carnivore' : 'Herbivore')
  end

  def reset(original)
    clear
    original.each { |dino| push(dino.dup) }
    self.is_pirate_list = original.is_pirate_list
  end

  def copy
    copied_dinos = DinoList.new
    each { |d| copied_dinos << d.dup }
    copied_dinos.is_pirate_list = is_pirate_list

    copied_dinos
  end
end
