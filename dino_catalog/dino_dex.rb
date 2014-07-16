require './dino'
require 'hirb'
require 'json'

class DinoDex

  def initialize(*files)

    @dex_array = []

    if files.nil? || files.size == 0
      raise 'We have no files to initialize our Dino Dex!'
    else
      files.each do |file|
        process_file(file)
      end
    end

  end


  def filter
    DinoDexSearch.new(@dex_array)
  end



  def process_file(file)

    File.open(file, "r") do |source|

      enum = source.each

      header = enum.next

      config = process_header(header)

      enum.each do |c|

        # split items
        items = c.split(',')
        # remove whitespace at the end
        items = items.map do |i|
          i.gsub(/\s\z/,"")
        end

        # make the default nil
        # this is used in the Dino initialize
        dino_hash = Hash.new(nil)

        config.each_with_index do |key, index|

          if key == :special_diet_carnivore
            if(items[index] == "Yes")
              dino_hash[:diet] = "Carnivore"
            else
              # Leave this field nil?
              dino_hash[:diet] = nil
            end
          else
            dino_hash[key] = items[index]
          end

        end

        @dex_array << Dino.new(dino_hash)

      end

    end


  end

  def process_header(header)

    # split header
    columns = header.split(',')
    # remove whitespace, make lowercase
    columns = columns.map do |h|
      h.gsub(/\s+/,"").downcase
    end

    columns.map do |h|
      Dino.get_symbol_key(h)
    end


  end


  # Not sure what the defacto is here for access (?)
  private :process_file, :process_header


end


class DinoDexSearch

  def initialize(dex)
    @dex = dex
  end

  def where(key, value)

    @dex.keep_if do |h|
      h.instance_variable_get("@#{key}") == value
    end

    self
  end


  def where_in(key, *values)

    @dex.keep_if do |h|

      keep = false

      values.each do |value|
        if h.instance_variable_get("@#{key}") == value
          keep = true
        end
      end


      keep
    end

    self
  end



  def more_than(key, value)
    @dex.keep_if do |h|
      h.instance_variable_get("@#{key}").to_i > value
    end

    self
  end

  def do_sort
    @dex.sort! do |a,b|
      a.name.downcase <=> b.name.downcase
    end
  end


  def print

    do_sort

    display_array = []


    @dex.each do |dino|
      display_array <<
        [
          dino.name, dino.period, dino.continent,
          dino.diet, dino.weight, dino.walking,
          dino.description
        ]
    end


    puts Hirb::Helpers::AutoTable.render(display_array,
      :headers =>
        %w(NAME PERIOD CONTINENT DIET
          WEIGHT WALKING DESCRIPTION))


  end

  def export_json

    do_sort

    json_array = []

    @dex.each do |dino|
      json_array << dino.to_json_hash
    end


    puts JSON.generate(json_array)


  end

end


# Start of testing this stuff out (the implementation is a bit rough..)

# Skip validation of locale
I18n.enforce_available_locales = false

dex = DinoDex.new('dinodex.csv','african_dinosaur_export.csv')


# dex.filter().print()

dex.filter().export_json()

# dex.filter().where(:walking, "Biped")
# 	.print()


# dex.filter().where(:walking, "Biped")
#   .where_in(:diet, "Carnivore", "Insectivore", "Piscivore")
#   .print()


# dex.filter().where(:walking, "Biped")
# 	.where(:diet, "Carnivore")
# 	.more_than(:weight, 2000)
# 	.print()


# dex.filter().where(:walking, "Biped")
# 	.where(:diet, "Carnivore")
# 	.where_in(:diet, "Carnivore", "Insectivore", "Piscivore")
# 	.where_in(:period, "Late Cretaceous", "Early Cretaceous")
# 	.more_than(:weight, 2000)
# 	.print()
