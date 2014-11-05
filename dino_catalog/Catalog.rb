require 'pry'
require 'csv'
require 'json'
require 'table_print'
require './Dinosaur'
require './CSVConverters'

class Catalog
  include CSVConverters
  attr_reader :dinosaurs

  def initialize(*csv_list)
    @dinosaurs = []
    @periods = []

    csv_list.each do |csv|
      parse_csv(csv)
    end
    binding.pry
  end

  def biped_filter
    tp @dinosaurs.uniq, :name, :walking
    input = ''

    until ['b', 'q', 'a'].include? input
      puts "B)iped or Q)uadruped or A)ll?"
      input = STDIN.gets.chomp.downcase
    end

    if input == 'b'
      @dinosaurs.select! { |dino| dino.walking == 'Biped' }
    elsif input == 'q'
      @dinosaurs.select! { |dino| dino.walking == 'Quadruped' }
    end
    self
  end 

  def carnivore_filter
    tp @dinosaurs, :name, :carnivore
    input = ''

    until ['c', 'n', 'a'].include? input
      puts "C)arnivore, N)not carnivore, or A)ll"
      input = STDIN.gets.chomp.downcase
    end

    if input == 'c'
      @dinosaurs.select! { |dino| dino.carnivore == 'Yes' }
    elsif input == 'n'
      @dinosaurs.select! { |dino| dino.carnivore == 'No' }
    end
    self
  end

  def period_filter
    tp @dinosaurs.uniq, :name, :period
    puts "What time period? or A)ll"
    input = STDIN.gets.chomp.capitalize

    return self if input == 'A' 
    @dinosaurs.select! { |dino| dino.period == input }
    self
  end

  def size_filter
    tp @dinosaurs, :name, :weight
    input = ''

    until ['g', 'l', 'a'].include? input
      puts "G)reater or L)ess than 2 tons? or A)ll"
      input = STDIN.gets.chomp.downcase
    end

    if input == 'g'
      @dinosaurs.select! { |dino| dino.weight && dino.weight > 2000 }
    elsif input == 'l'
      @dinosaurs.select! { |dino| dino.weight && dino.weight <= 2000 }
    end
    self
  end

  def output
    @dinosaurs.empty? ? puts('No dinosaurs fit your criteria.') : tp(dinosaurs)
  end

  def output_json
    results = []
    @dinosaurs.each do |d|
      results << d.to_h.to_json
    end
    results
  end

  private

  def parse_csv(csv)
    csv = CSV.new( File.open(csv), 
      headers: true, 
      header_converters: [:symbol, :conv_genus, :conv_weight],
      converters: [:integer]
    )
    load_dinos( csv.to_a.map { |row| row.to_hash } )
  end

  def load_dinos(dino_hash)
    dino_hash.map! { |dino| @dinosaurs << Dinosaur.new(dino) }
  end
end

if __FILE__ == $0
  Dino_Ctg = Catalog.new(ARGV[0], ARGV[1])
  Dino_Ctg.biped_filter.carnivore_filter.period_filter.size_filter.output
end
