require 'csv'
require_relative './dinosaur.rb'

class Parser

  FILES = %w(dinodex.csv african_dinosaur_export.csv)

  def self.parse
    dinos = []
    FILES.each do |file|
      csv = CSV.open(file)
      header = csv.first.map(&:downcase)
      data = csv.to_a[1..-1]

      index = header.index("weight")
      header[index] = "weight_in_lbs" if index

      data.map do |row|
        args = header.zip(row).to_h
        dino = Dinosaur.new(args)
        dinos << dino
      end
    end
    dinos
  end
end
