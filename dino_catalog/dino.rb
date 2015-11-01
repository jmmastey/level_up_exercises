# User stories:
  # As a user, I want to take in 2 types of csv files and combine the data into one data structure
  # As a user, I want to be able to query my data, with parameters that may change
  #
  #




require 'csv'

# There are 2 types of files that will be passed. The difference between
# them is the columns count and some labeling.

class DinoDex

  attr_reader :all_dinosaurs, :data_source_A, :data_source_B

  def initialize(opts={})
    @all_dinosaurs = Array.new
    @data_source_A = opts[:data_source_A]
    @data_source_B = opts[:data_source_B]
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

  def seed_dino
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

      @all_dinosaurs << temp
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

      @all_dinosaurs << temp
    end

    return @all_dinosaurs
  end

  # def format_data_A(headers, data)
  #   data.each do |row|
  #     p row.class
  #   end
  #   headers
  # end

  # def format_data_B(headers)
  #
  # end



  def parse_csv_with_CSV(input_file)
    data = Array.new
    CSV.foreach(input_file, headers: true, header_converters: :downcase) do |row|
      data << row
    end

    data.each do |row|

      @dino_hash[row["name"].to_sym] = row
    end
  end

  def parse_csv_with_File(input_file)
    # Data structures
    data = Array.new

    # Iterate through csv, without csv module, remove new line char and append to array structure
    File.open(input_file).each do |row|
      data << row.sub(/\n/, "")
    end

    # Retrieve headers from data
    headers = data[0].split(",")

    # Iterate through data without headers
    data[1..-1].each do |row|

      # temporary placeholder for data
      temp = {}

      row_split_data = row.split(",")

      # Combine headers with rows
      headers.each.with_index do |header, i|

        # traverses split data and combines it with the header, as a symbol
        temp[header.downcase.to_sym] = row_split_data[i]

        # Adds to main data structure
        @dino_hash[temp[:name]] = temp
      end
    end
    return @dino_hash
  end

end

# TODO
  # The foreach method from the CSV doesn't give me enough leverage. Will prob stick to writing my own.

dino_instance = DinoDex.new({data_source_A: "dinodex.csv",
                             data_source_B: "african_dinosaur_export.csv"})
dino_instance.seed_dino
dino_instance.all_dinosaurs
