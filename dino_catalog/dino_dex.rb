require 'rubygems'
require 'active_support/all'
require 'table_print'
require 'csv'
require 'json'
require './dinosaur.rb'

class DinoDex

  attr_accessor :dinosaurs

  def initialize
    parse_csv
    print_to_console(@dinosaurs)
  end

  def dinosaurs
    print_to_console(@dinosaurs)
  end

  def search(options = {})
    result = []
    options.each do |k, v|
      operator = "=="
      if k == :weight
        operator = ">" if v[0] == "+"
        operator = "<" if v[0] == "-"
        value = v.to_i
        value = v[1..-1].to_i if v[0] == "-"
      else
        value = v.downcase
      end
      result << @dinosaurs.select { |dino| dino[k].send(operator, value) }
    end
    result.flatten
  end

  def dinosaur_details(dinosaur)
    print_to_console(dinosaur = self.search(:name => dinosaur))
  end

  def export_to_json
    if @dinosaurs.empty?
      raise "Your dinosaur list is empty! There's nothing to export!"
    else
      @dinosaurs.to_json
    end
  end

  private


    def parse_csv
      @dinosaurs = []
      ['./dinodex.csv', './african_dinosaur_export.csv'].each do |csv|
        CSV.foreach(csv, :headers => true, :header_converters => :symbol) do |obj|
         dino = Dinosaur.new(:name => obj[:name] || obj[:genus],
                             :period => obj[:period],
                             :continent => obj[:continent],
                             :diet => obj[:diet] || (obj[:carnivore] == 'yes' ? 'Carnivore' : 'Non-carnivore'),
                             :weight => (obj[:weight_in_lbs] || obj[:weight]).to_i,
                             :ambulation => obj[:walking],
                             :description => obj[:description])
        @dinosaurs << dino.to_hash
        end
      end
      if @dinosaurs.empty?
        puts "Your have no dinosaurs! Oh noes!"
      else
        puts "Your dinosaurs are loaded go and search big boy!"
      end
    end

    def print_to_console(dinosaurs)
      tp dinosaurs
    end

end
