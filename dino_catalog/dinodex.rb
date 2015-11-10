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
    csv = CSV.foreach(filename, headers: true, header_converters: :symbol, converters: [:all, :blank_to_nil])
    csv.to_a.map {|row| row.to_hash }
  end

  # def 
    
  # end
end

d = Dinodex.new
binding.pry
puts d.african_dinos
puts d.dinos
