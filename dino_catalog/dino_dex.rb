require 'rubygems'
require 'active_support/all'
require 'table_print'
require 'csv'
require 'json'
require './dinosaur.rb'
require './dino_csv.rb'

class DinoDex
  attr_accessor :dinosaurs

  DEFAULT_FILES = ['./dinodex.csv', './african_dinosaur_export.csv']

  def initialize(files = [])
    load_csv_files(files)
    print_to_console(@dinosaurs)
  end

  def all_dinosaurs
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
    tp result.flatten
  end

  def load_csv_files(files = [])
    if files.empty?
      @dinosaurs = DinoCsv.new(DEFAULT_FILES).results.flatten
    else
      @dinosaurs = DinoCsv.new(files).results.flatten
    end
  end

  def export_to_json
    if @dinosaurs.empty?
      raise "Your dinosaur list is empty! There's nothing to export!"
    else
      @dinosaurs.to_json
    end
  end

  private

  def print_to_console(dinosaurs)
    tp dinosaurs
  end
end

dino_catalog = DinoDex.new
