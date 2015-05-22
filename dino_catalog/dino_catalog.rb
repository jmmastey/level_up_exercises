require 'csv'
require_relative 'dino'

class DinoCatalog

  attr_accessor :dinos

  def initialize(csv_filename=nil)
    self.dinos ||=[]

    if csv_filename
      load(csv_filename)
    end

  end

  def bipeds
    find(options: { walking: 'biped' })
  end

  def carnivores
    find(options: {carnivore: 'yes'})
  end

  def period(name)
    find(options: {period: name})
  end

  #more than 2000 Lbs in weight
  def big_dinos(reverse: false)

    large_dinos = []

    dinos.each do |d|
      large_dinos << d if d.weight && d.weight >= 1000
      large_dinos << d if d.weight_in_lbs && d.weight_in_lbs >= 2000
    end

    reverse ? self.dinos - large_dinos : large_dinos
  end

  def small_dinos
    big_dinos(reverse: true)
  end

  def find(options: {})
    filtered_dinos = dinos

    options.each do |filter_attr, filter_value|
      puts filtered_dinos.length
      filtered_dinos = filter(filtered_dinos, filter_attr, filter_value, options[:filter_type])
      puts filtered_dinos.length
    end

    #retruning cagalog allows chain formation.
    filtered_catalog = self.clone
    filtered_catalog.dinos = filtered_dinos
    filtered_catalog
  end

  private

  def filter(unfiltered_dinos, filter_attr, filter_value, filter_type)
    filtered_dinos = []

    unfiltered_dinos.each do |dino|
      next unless dino.instance_variables.to_s.include?(":@#{filter_attr}")
      filtered_dinos << dino if include_dino?(dino, filter_attr, filter_value, filter_type)
    end

    filtered_dinos
  end

  def include_dino?(dino, filter_attr, filter_value, filter_type)
    dino.send(filter_attr.to_s).downcase.include?(filter_value.downcase) &&
      filter_type != :exclude
  end

  def display(my_dinos: self.dinos, header: '')
    puts 'Displaying ' + header + ' dinosaurs'
    my_dinos.each { |d| puts d.name }
  end

  def load(csv_filename)
    puts 'Loading dinos form '+csv_filename+ ' file'
    @catalog_source_file = csv_filename

    dino_csv = CSV.open(csv_filename)
    headers = dino_csv.readline

    dino_csv.readlines.each do |row|
       new_dino = Dino.new(attributes: headers, details: row)
       self.dinos << new_dino
    end
  end

end
