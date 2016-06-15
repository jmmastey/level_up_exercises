require 'csv'
require 'pry'
require_relative 'dinosaur'

class DinodexReader

  def initialize(path, type)
    @path = path
    @type = type
  end

  def fetch
    read_csv_normal if @type == 'none'
  end

  def read_csv_normal
    dinosaurs = []
    CSV.foreach(@path, { headers: true }) do |row|
      dinosaurs << create_dinosaur(row)
    end
    dinosaurs
  end

  def create_dinosaur(options)
    Dinosaur.new(options.to_h)
  end

end
