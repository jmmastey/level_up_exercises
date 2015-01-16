require 'csv'
require_relative 'dino'
require_relative 'dinoset'

class Dinodex
  attr_reader :all

  def initialize(csv_file = 'dinodex.csv', dino_class = Dino)
    @csv_file = csv_file
    @all      = DinoSet.new(read_csv.map { |hash| dino_class.new(hash) })
  end

  def method_missing(method, *args)
    return all.send(method) if all.respond_to?(method)
    super
  end

  private

  def read_csv
    CSV.table(@csv_file).each_with_object([]) do |i, arr|
      arr << Hash[i.to_h.map { |k, v| [k.downcase.to_sym, v] }]
    end
  end
end
