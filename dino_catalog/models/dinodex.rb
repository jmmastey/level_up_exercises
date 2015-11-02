require 'set'
require 'json'

class DinoDex

  attr_reader :all_dinosaurs, :data_source_A, :data_source_B

  def initialize(opts={})
    @all_dinosaurs = Array.new
    @data_source_A = opts[:data_source_A]
    @data_source_B = opts[:data_source_B]
    @json_data = Array.new
  end


  def parse_csv_to_array_of_arrays(input_file)
    # Data structures - helper
    data = Array.new

    # Iterate through csv, without csv module, remove new line char and append to array structure
    File.open(input_file).each do |row|
      data << row.sub(/\n/, "").split(",")
    end

    return data
  end

  def seed
    # Parses CSVs, skips headers
    data_A = parse_csv_to_array_of_arrays(@data_source_A).drop(1)
    data_B = parse_csv_to_array_of_arrays(@data_source_B).drop(1)

    # use method to parse to arrays, skips headers
    data_A.each do |row|
      # helper structure
      temp = {}

      # Parses data by slicing the row at an index
      temp[:name]         = row[0]
      temp[:period]       = row[1]
      temp[:continent]    = row[2]
      temp[:diet]         = row[3]
      temp[:weight_lbs]   = row[4].to_i
      temp[:walking]      = row[5]
      temp[:description]  = row[6]

      @all_dinosaurs << Dinosaur.new(temp)
      @json_data << temp
    end

    data_B.each do |row|
      # helper structure
      temp = {}

      # Parses data by slicing the row at an index
      temp[:name]         = row[0]
      temp[:period]       = row[1]
      temp[:continent]    = nil
      temp[:diet]         = row[2] == "Yes" ? "Carnivore" : nil
      temp[:weight_lbs]   = row[3].to_i
      temp[:walking]      = row[4]
      temp[:description]  = nil

      @all_dinosaurs << Dinosaur.new(temp)
      @json_data << temp
    end

    return @all_dinosaurs
  end

  def fetch_biped
    @all_dinosaurs.select { |dino| dino.biped? == true}
  end

  def fetch_big
    @all_dinosaurs.select { |dino| dino.big? == true}
  end

  def fetch_small
    @all_dinosaurs.select { |dino| dino.small? == true }
  end

  def fetch_carnivore
    @all_dinosaurs.select { |dino| dino.carnivore? == true}
  end

  def fetch_period(input_period)
    @all_dinosaurs.select { |dino| dino.period.include?(input_period)}
  end

  def master_fetch(opts={})
    # Helper data struc
    temp = []

    opts.each do | key, value |

      case value

      when "fetch_biped"
        temp << fetch_biped

      when "fetch_big"
        temp << fetch_big

      when "fetch_small"
        temp << fetch_small

      when "fetch_carnivore"
        temp << fetch_carnivore

      # This is a hacky solution to this problem. This fetches the result we want and we are able to pass
      # the params through the call. Would really love to see a cleaner implementation for this problem.
      when "fetch_period"
        temp << fetch_period(key)
      end
    end

    # will use set to remove duplicates
    return Set.new(temp)
  end

  def display_group(group)
    # Helper
    group_string = ""

    group.each do |dino|
       group_string += dino.display
    end
    return group_string
  end

  def export_json
    @json_data.to_json
  end

end
