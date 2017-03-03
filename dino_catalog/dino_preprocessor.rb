require_relative 'dinosaur.rb'
require_relative 'dino_csv_cleaner'

class DinoPreprocessor
  attr_accessor :new_csv, :all_dinos

  def initialize(files)
    @dino_hash = DinoCsvCleaner.new(files)
    @new_csv = read_new_csv
    @all_dinos = create_dino_object
  end

  def read_new_csv
    keys = open('new.csv')
    csv = CSV.new(keys, headers: true, header_converters: :symbol, converters: :all)
    csv.to_a.map(&:to_hash)
  end

  def create_dino_object(all_dinos = [])
    @new_csv.map do |d|
      dino = Dinosaur.new
      dino.create_attribute(@dino_hash.csv_headers)
      d.each { |k, _| dino.send("#{k}=", d[k]) }
      all_dinos << dino
    end
    all_dinos
  end
end
