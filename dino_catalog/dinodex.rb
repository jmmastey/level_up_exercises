class DinoDex
  require 'csv'
  require 'json'

  @@dino_database = []

  # Read main CSV file into an array of hashes

  CSV.foreach('dinodex.csv', headers: true) do |row|
    @@dino_database << row.to_hash
  end

  # Read Pirate Bay CSV file and merge the results

  CSV.foreach('african_dinosaur_export.csv', headers: true) do |row|
    diet = row[:Carnivore].downcase == 'yes' ? 'Carnivore' : nil

    @@dino_database << {
      :NAME => row['Genus'],
      :PERIOD => row['Period'],
      :CONTINENT => nil,
      :DIET => diet,
      :WEIGHT_IN_LBS => row['Weight'],
      :WALKING => row['Walking'],
      :DESCRIPTION => nil
    }
  end

  # Search for dinosaurs based on various criteria

  def search(search_filters)
    results = []

    search_filters.each do |key, value|
      if value.class == Array

        # Match against multiple string values

        results.push(@@dino_database.select) do |dino| 
          value.downcase.include?(dino[key].downcase)
        end

      else

        if key == 'min_weight'

          # We treat min_weight differently than a regular string match

          results.push(@@dino_database.select do |dino|
            if dino[:WEIGHT_IN_LBS]
              dino[:WEIGHT_IN_LBS].to_i >= value
            end
          end)

        else

          # Match against string value

          results.push(@@dino_database.select do |dino|
            if dino[key]
              dino[key].downcase.include? value.downcase
            end
          end)

        end
      end
    end

    # print JSON
    puts results.to_json
  end
end

dinodex = DinoDex.new

# Grab all dinosaurs that were bipeds
dinodex.search(:WALKING => 'Biped')

# Grab all the dinosaurs that were carnivores (fish and insects count).
# dinodex.search('DIET' => ['Carnivore', 'Insectivore', 'Piscivore'])

# Grab dinosaurs for specific periods
# dinodex.search('PERIOD' => 'Cretaceous')

# Grab only big (> 2 tons) or small dinosaurs.
# dinodex.search('min_weight' => 2000)

# Print out details of a specific dinosaur
# dinodex.search('NAME' => 'Albertonykus')
