require 'csv'

class DinoDex
  DINO_FILENAME1 = "dinodex.csv"
  DINO_FILENAME2 = "african_dinosaur_export.csv"

  attr_accessor :dino_data

  def initialize
    @dino_data = parse_dino_files
  end

  def parse_dino_files
    dino_data1 = CSV.read(DINO_FILENAME1, headers: true)
    dino_data2 = CSV.read(DINO_FILENAME2, headers: true)

    prune_period_values(merge_data(dino_data1, dino_data2))
  end

  def display_all_bipeds
    display_header "All Bipeds"
    display_names grab_all_bipeds
  end

  def display_all_carnivores
    display_header "All Carnivores"
    display_names grab_all_carnivores
  end

  def display_all_jurassics
    display_header "All Jurassics"
    display_names grab_all_jurassics
  end

  def display_all_big_dinos
    display_header "All Big Dino's"
    display_names grab_all_big_dinos
  end

  def display_all_small_dinos
    display_header "All Small Dino's"
    display_names grab_all_small_dinos
  end

  def display_all_facts_about(dino_name)
    display_header "All About #{dino_name}"
    display_dino grab_dino_by_name(dino_name)
  end

  def display_dino(csv_table)
    csv_table.each do |row|
      row.each do |header, field|
        if field
          display header + ": " + field
        end
      end
      display_line_break
    end
  end

  def display_dinos(dino_list)
    display_header "List of Dino's!"
    display_dino dino_list
  end

  def grab_all_bipeds
    filter_by_column("WALKING", "Biped")
  end

  def grab_all_carnivores
    filter_by_column("DIET", "Carnivore")
  end

  def grab_all_jurassics
    filter_by_column("PERIOD", "Jurassic")
  end

  def grab_all_big_dinos
    filter_by_weight_greater_than_or_equal_to(2000)
  end

  def grab_all_small_dinos
    filter_by_weight_less_than(2000)
  end

  def grab_dino_by_name(dino_name)
    filter_by_column("NAME", dino_name)
  end

  private

  # Duplicating this CSV table is inefficient and won't scale with larger sets
  # of data.  I'm lazy.
  def duplicate_csv_table(csv_table)
    CSV.parse(csv_table.to_s, headers: true)
  end

  def filter_by_weight_greater_than_or_equal_to(weight)
    duplicate_csv_table(@dino_data).delete_if do |row|
      (row["WEIGHT_IN_LBS"].to_i <= weight.to_i) ||
        (row["WEIGHT_IN_LBS"].to_i == 0)
    end
  end

  def filter_by_weight_less_than(weight)
    duplicate_csv_table(@dino_data).delete_if do |row|
      (row["WEIGHT_IN_LBS"].to_i > weight.to_i) ||
        (row["WEIGHT_IN_LBS"].to_i == 0)
    end
  end

  def filter_by_column(column, filter)
    duplicate_csv_table(@dino_data).delete_if do |row|
      row[column] != filter
    end
  end

  # This data transformation is brittle, be careful.
  def merge_data(csv_table1, csv_table2)
    csv_table2.each do |row|
      csv_table1 << [
        row["Genus"],                         # NAME
        row["Period"],                        # PERIOD
        nil,                                  # CONTINENT
        convert_carnivore(row["Carnivore"]),  # DIET
        row["Weight"],                        # WEIGHT_IN_LBS
        row["Walking"],                       # WALKING
        nil                                   # DESCRIPTION
      ]
    end

    csv_table1
  end

  def prune_period_values(csv_table)
    csv_table.each do |row|
      row["PERIOD"].gsub!("Late ", "")
      row["PERIOD"].gsub!("Early ", "")
    end

    csv_table
  end

  def convert_carnivore(carnivore_bool)
    return "Carnivore" if carnivore_bool == "Yes"
    "Herbivore"
  end

  def display(message)
    puts message
  end

  def display_header(message)
    display_line_break
    display message
    display_line_break
  end

  def display_column(csv_table, column)
    csv_table.each do |row|
      display row[column]
    end
  end

  def display_names(csv_table)
    display_column(csv_table, "NAME")
  end

  def display_line_break
    display "--------------------------------------"
  end
end

# 1. parse both csv files
dino = DinoDex.new

# 2. answer these questions
## display all dinosaurs that were bipeds
dino.display_all_bipeds

## display all dinosaurs that were carnivores, including insects and fish
dino.display_all_carnivores

## display dinosaurs for specific periods
dino.display_all_jurassics

## display only big dinosaurs (> 2 tons)
dino.display_all_big_dinos

## display only small dinosaurs (< 2 tons)
dino.display_all_small_dinos

# 3. display all the facts for a given dino
dino.display_all_facts_about "Albertosaurus"

# 4. display all the dinosaurs in a given collection
dino.display_dinos dino.grab_all_small_dinos
