require 'pry'
require 'csv'

CSV::Converters[:blank_to_nil] = lambda do |field|
  field && field.empty? ? nil : field
end

class Dinodex
  attr_accessor :african_dinos, :dinos

  def initialize
    @african_dinos = import_file("african_dinosaur_export.csv")
    @dinos = import_file("dinodex.csv")
  end

  def import_file(filename)
    # csv = CSV.read(filename, headers: true, header_converters: lambda { |h| header_translator(h) })
    # puts csv.inspect
    # binding.pry
    csv = CSV.foreach(filename, headers: true, header_converters: :symbol, converters: [:all, :blank_to_nil])
    csv.to_a.map { |row| row.to_hash }
  end

  def translate_files

  end

  # def header_translator(h)
  #   new_h = h.to_sym
  #   translate = {
  #     genus: :name,
  #     period: :period,
  #     continent: :continent,
  #     carnivore: :diet,
  #     diet: :diet,
  #     weight: :pounds,
  #     weight_in_lbs: :pounds,
  #     walking: :walking,
  #     description: :description,
  #   }
  #   translate[new_h]
  # end
end

d = Dinodex.new
puts d.african_dinos
puts d.dinos

