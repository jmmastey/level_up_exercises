# DinoDex is the main class
class DinoDex
  require 'csv'
  SIZE_VALUE = 4000

  def initialize(name_csv)
    @dinosaurs = {}
    CSV.foreach(name_csv,
                headers: true,
                header_converters: :symbol,
                converters: :all)do |row|
      @dinosaurs[row.fields[0]] =
          Hash[row.headers[0..-1].zip(row.fields[0..-1])]
    end
  end

  def simple_dino_filter(dino_attrb, dino_value)
    dino_attrb_sym = dino_attrb.to_sym

    puts @dinosaurs.select {|_dinosaur, dinoatrributes|
           dinoatrributes[dino_attrb_sym] == dino_value
         }
  end

  def diet_dino_filter(dino_attrb, dino_value)
    dino_attrb_sym = dino_attrb.to_sym
    puts @dinosaurs.select {|_dinosaur, dinoatrributes|
           dino_value.include? dinoatrributes[dino_attrb_sym]
         }
  end

  def size_dino_filter_big(dino_size_attrb)
    dino_attrb_sym = dino_size_attrb.to_sym
    puts @dinosaurs.select{|_dinosaur, dinoatrributes|
           dinoatrributes[dino_attrb_sym] &&
             dinoatrributes[dino_attrb_sym] > SIZE_VALUE
         }
  end

  def size_dino_filter_small(dino_size_attrb)
    dino_attrb_sym = dino_size_attrb.to_sym
    puts @dinosaurs.select{|_dinosaur, dinoatrributes|
           dinoatrributes[dino_attrb_sym] &&
             dinoatrributes[dino_attrb_sym] < SIZE_VALUE
         }
  end

  def size_dino_complexfilter_big(dino_size_attrb, dino_attrb, dino_value)
    dino_size_sym = dino_size_attrb.to_sym
    dino_attrb_sym =  dino_attrb.to_sym
    puts @dinosaurs.select{|_dinosaur, dinoatrributes|
           dinoatrributes[dino_size_sym] &&
             dinoatrributes[dino_size_sym] > SIZE_VALUE &&
             dinoatrributes[dino_attrb_sym] == dino_value
         }
  end

  def size_dino_complexfilter_small(dino_size_attrb, dino_attrb, dino_value)
    dino_size_sym = dino_size_attrb.to_sym
    dino_attrb_sym =  dino_attrb.to_sym
    puts @dinosaurs.select{|_dinosaur, dinoatrributes|
           dinoatrributes[dino_size_sym] &&
             dinoatrributes[dino_size_sym] < SIZE_VALUE &&
             dinoatrributes[dino_attrb_sym] == dino_value
         }
  end

  # need one for Diet and other attributes.
  def diet_dino_complex(dino_attrb_one, dino_value_one,
                        dino_attrb_two, dino_value_two)
    dino_attrb_sym_one = dino_attrb_one.to_sym
    dino_attrb_sym_two = dino_attrb_two.to_sym
    puts @dinosaurs.select{|_dinosaur, dinoatrributes|
           dinoatrributes[dino_attrb_sym_one] &&
             dinoatrributes[dino_attrb_sym_two] &&
             dinoatrributes[dino_attrb_sym_one] == dino_value_one &&
             dinoatrributes[dino_attrb_sym_two] == dino_value_two
         }
  end

  # need one for Diet and other attributes.
  def size_dino_complex(dino_attrb_one, dino_value_one,
                        dino_attrb_two, dino_value_two)
    dino_attrb_sym_one = dino_attrb_one.to_sym
    dino_attrb_sym_two = dino_attrb_two.to_sym
    puts @dinosaurs.select{|_dinosaur, dinoatrributes|
           dino_value_one.include? dinoatrributes[dino_attrb_sym_one]
           dinoatrributes[dino_attrb_sym_two] == dino_value_two
         }
  end
end

# Just uncomment any condition/filter you want to test.
# and uncomment the creation of dinodex
# choose which csv to work with

# dinoDex = DinoDex.new("dinodex.csv")
# dinoDex = DinoDex.new("african_dinosaur_export.csv")

# Grab all dinosars that were bipeds
# dinoDex.simple_dino_filter("walking", "Biped" )

# Grab all dinosaurs that were carnivores
# and grab all dinosaurs who ate fish and insect
# dinoDex.diet_dino_filter("diet",
# ['Carnivore','Insectivore','Piscivore'] )

# Grab dinosaurs for specific periods(no need to
# differentiate between Early and Late Cretaceous)
# dinoDex.simple_dino_filter("period", "Late Cretaceous" )

# Grab all dinosaurs that are big
# dinoDex.size_dino_filter_big("weight_in_lbs" )

# Grab all dinosaurs that are small
# dinoDex.size_dino_filter_small("weight_in_lbs" )

# Combine criteria, you can select big and another criteria
# dinoDex.size_dino_complexfilter_big("weight_in_lbs",
# "period","Early Cretaceous")

# Combine criteria, you can select small and another criteria
# dinoDex.size_dino_complexfilter_small('weight_in_lbs','period',
# 'Early Cretaceous')

# Combine Criteria,  you can select carnivore and any other criteria
#  dinoDex.size_dino_complex('diet',['Carnivore','Insectivore','Piscivore'],
# 'continent', 'North America')

# This also works for african_dinosaur_export.csv,
# sample filters just change the file
# in the constructor to african_dinosaur_export.csv
# dinoDex.simple_dino_filter("genus", "Abrictosaurus" )
# dinoDex.simple_dino_filter("period", "Cretaceous")

# For a given dino,
# I'd like to be able print all the known facts about a dinosaur
# dinoDex.simple_dino_filter("name", "Albertosaurus" )
