require 'csv'
class Dinosaurs
  attr_accessor :name,:period,:continent,:diet,:weight,:walking,:description

  def initialize(opts)
    @name = opts[:name]
    @period = opts[:period]
    @continent = opts[:continent]
    @diet = opts[:diet]
    @weight = opts[:weight]
    @walking = opts[:walking]
    @description = opts[:description]
  end

  def to_hash
    {
        name: @name,
        period: @period,
        continent: @continent,
        diet: @diet,
        weight: @weight,
        walking: @walking,
        description: @description
    }
  end

  def to_json(*args)
    to_hash.to_json(*args)
  end

end



class DinoDex
  attr_accessor :dinos

  def initialize(dinos=[])
    @output=[]
    @dinos = dinos
  end


  def diet_for_african_dino(is_carnivore)
    if is_carnivore == "Yes"
      "Carnivore"
    elsif is_carnivore == "No"
      "Non-carnivore"
      else
      nill
    end
  end



    def parser_file(file_paths)
    file_paths.each do |file_path|
        CSV.foreach(file_path, headers: true) do |row|
              name = row['Genus']|| row['NAME']
              period = row['Period']|| row['PERIOD']
              continent = row['CONTINENT'] || 'Africa'
              diet =row['DIET']|| diet_for_african_dino(row['Carnivore'])
              weight =row['Weight']|| row['WEIGHT_IN_LBS']
              walking = row['Walking']|| row['WALKING']
              description =row['DESCRIPTION']
        @dinos << Dinosaurs.new(name: name,
                         period: period,
                         continent: continent,
                         diet: diet,
                         weight: weight,
                         walking: walking,
                         description: description)

         end
    end
    @dinos
  end


  def bipeds
    filtered_dinos = @dinos.select do |dino|
        dino.walking =="Biped"
        end
      filtered_dinos
  end



  def small
    filtered_dinos = @dinos.select do |dino|
      dino.weight.to_i <= 2000
    end
    filtered_dinos
  end


  def big
    filtered_dinos = @dinos.select do |dino|
      dino.weight.to_i > 2000
    end
    filtered_dinos
  end


  def carnivores
    filtered_dinos = @dinos.select do |dino|
      dino if dino.diet != 'Non-carnivore'
     end
  filtered_dinos
  end


  def periods (periods)
    filtered_dinos= @dinos.select do |dino|
     dino.period.downcase.include? periods
    end
    filtered_dinos
  end


  def to_json
    @dinos.to_json
  end

end