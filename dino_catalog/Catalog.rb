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

  def bipeds
    tp @dinosaurs.uniq, :name, :walking
    ansr = ask_user(%w(B Q A), "B)iped or Q)uadruped or A)ll?")
    return self if ansr == 'A'
    ansr == 'B' ? filter('walking', 'Biped') : filter('walking', 'Quadruped')
    self
  end

  def carnivores
    tp @dinosaurs, :name, :carnivore
    ansr = ask_user(%w(C N A), "C)arnivore, N)not carnivore, or A)ll")
    return self if ansr == 'A'
    ansr == 'C' ? filter('carnivore', 'Yes') : filter('carnivore', 'No')
    self
  end

  def periods
    tp @dinosaurs.uniq, :name, :period
    ans = ask_user(
      @dinosaurs.map { |dino| dino.period.capitalize } << 'A',
      "What time period? or A)ll",
    )
    ans == 'A' ? (return self) : filter('period', ans.capitalize)
    self
  end

  def size
    tp @dinosaurs, :name, :weight
    ansr = ask_user(%w(G L A), "G)reater or L)ess than 2 tons? or A)ll")

    if ansr == 'G'
      @dinosaurs.select! { |dino| dino.weight && dino.weight > 2000 }
    elsif ansr == 'L'
      @dinosaurs.select! { |dino| dino.weight && dino.weight <= 2000 }
    end
    self
  end

  def output
    @dinosaurs.empty? ? puts('No dinosaurs fit your criteria.') : tp(dinosaurs)
  end

  def to_json
    results = []
    @dinosaurs.each { |d| results << d.to_h.to_json }
    results
  end

  private

  def ask_user(attrs, prompt)
    input = ''
    until attrs.include? input
      puts prompt
      input = STDIN.gets.chomp.capitalize
    end
    input
  end

  def filter(attrib, value)
    @dinosaurs.select! do |dino|
      dino.instance_variable_get("@#{attrib}") == value
   end
  end

  def parse_csv(csv)
    csv = CSV.new(File.open(csv),
      headers: true,
      header_converters: [:conv_genus, :conv_weight, :symbol],
      converters: [:integer],
    )
    load_dinos(csv.to_a.map(&:to_hash))
  end

  def load_dinos(dino_hash)
    dino_hash.map! { |dino| @dinosaurs << Dinosaur.new(dino) }
  end
end

if __FILE__ == $PROGRAM_NAME
  dino_catalog = Catalog.new(ARGV[0], ARGV[1])
  dino_catalog.bipeds.carnivores.periods.size.output
end
