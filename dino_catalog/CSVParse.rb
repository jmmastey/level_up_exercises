require 'csv'
require 'pp'
require_relative 'Dinosaur'

class CSVParse
  HEADER_TAG = {
    'genus' => 'name',
    'weight_in_lbs' => 'weight',
  }

  BIPED = 'biped'
  DINOS = []

  def parse_csv(input_csv)
    CSV.foreach(input_csv, headers: true,
      header_converters: [:downcase, ->(h) { HEADER_TAG[h] || h },
                          :symbol]
       ) do |row|
      DINOS.push(Dinosaur.new(row))
    end
    DINOS
  end
end
