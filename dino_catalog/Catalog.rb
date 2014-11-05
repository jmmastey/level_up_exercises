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
    weight = ''

    until ['g', 'l', 'a'].include? weight
      puts "G)reater or L)ess than 2 tons? or A)ll"
      weight = STDIN.gets.chomp.downcase
    end

    if weight == 'g'
      @dinosaurs.select! { |dino| dino.weight && dino.weight.to_i > 2000 }
    elsif weight == 'l'
      @dinosaurs.select! { |dino| dino.weight && dino.weight.to_i <= 2000 }
    end
    self
  end

  def output
    @dinosaurs.length > 0 ? tp(dinosaurs) : puts('No dinosaurs fit your criteria.')
  end

  def output_json
    json_out = {}
    @dinosaurs.each_with_index do |d, i|
      json_out[i] = {
        genus: d.genus,
        period: d.period,
        carnivore: d.carnivore,
        weight: d.weight,
        walking: d.walking,
        continent: d.continent,
        description: d.description
      }
    end
    json_out.to_json
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
