require 'pry'
require 'csv'
require 'json'
require 'table_print'
require './Dinosaur'
require './CSVConverters.rb'

class Catalog
  include CSVConverters
  attr_reader :dinosaurs

  def initialize(*csv_list)
    @dinosaurs = []

    csv_list.each do |csv|
      parse_csv(csv)
    end
  end

  def biped_filter
    tp @dinosaurs.uniq, :name, :walking
    ansr = request(%W(b q a), "B)iped or Q)uadruped or A)ll?")
    return self if ansr == 'a'
    ansr == 'b' ? filter('walking', 'Biped') : filter('walking', 'Quadruped')
    self
  end

  def carnivore_filter
    tp @dinosaurs, :name, :carnivore
    ansr = request(%W(c n a), "C)arnivore, N)not carnivore, or A)ll")
    return self if ansr == 'a'
    ansr == 'c' ? filter('carnivore', 'Yes') : filter('carnivore', 'No')
    self
  end

  def period_filter
    tp @dinosaurs.uniq, :name, :period
    ans = request(
      @dinosaurs.map{ |dino| dino.period.downcase } << 'a', 
      "What time period? or A)ll"
    )
    ans == 'a' ? (return self) : filter('period', ans)
    self
  end

  def size_filter
    tp @dinosaurs, :name, :weight
    ansr = request(%W(g l a), "G)reater or L)ess than 2 tons? or A)ll")

    if ansr == 'g'
      @dinosaurs.select! { |dino| dino.weight && dino.weight > 2000 }
    elsif ansr == 'l'
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

  def request(vars, prompt)
    input = ''
    until vars.include? input
      puts prompt
      input = STDIN.gets.chomp.downcase
    end
    input
  end

  def filter(attrib, value)
    @dinosaurs.select! { |dino| dino.instance_variable_get("@#{attrib}") == value }
  end

  def parse_csv(csv)
    csv = CSV.new(File.open(csv),
      headers: true,
      header_converters: [:conv_genus, :conv_weight, :symbol],
      converters: [:integer],
    )
    load_dinos(csv.to_a.map { |r| r.to_hash })
  end

  def load_dinos(dino_hash)
    dino_hash.map! { |dino| @dinosaurs << Dinosaur.new(dino) }
  end
end

if __FILE__ == $PROGRAM_NAME
  Dino_Ctg = Catalog.new(ARGV[0], ARGV[1])
  Dino_Ctg.biped_filter.carnivore_filter.period_filter.size_filter.output
end
