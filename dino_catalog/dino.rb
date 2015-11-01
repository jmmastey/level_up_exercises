# require 'csv'


def parse_csv_with_CSV(input_file)
  # There are 2 types of files that will be passed. The difference between
  # them is the columns count and some labeling.



end

def parse_csv_with_File(input_file)
  # Data structures
  data, dino_hash = Array.new, Hash.new

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
      dino_hash[temp[:name]] = temp
    end
  end
  return dino_hash
end

p parse_csv_with_File("dinodex.csv")
