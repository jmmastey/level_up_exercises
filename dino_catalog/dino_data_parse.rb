require 'csv'
require_relative 'dino'

class DinoDataParser
  attr_accessor :file, :dinos

  def initialize(file)
    @file = file
    @dinos = parse
  end

  def parse
    data = []

    CSV.foreach(@file, parse_opts) do |row|
      row = row.to_hash
      data << Dinosaur.new(row)
    end
    data
  end

  private

  def parse_opts
    {
      headers:           true,
      return_headers:    false,
      header_converters: [:symbol],
      converters:        [:all],
    }
  end
end
