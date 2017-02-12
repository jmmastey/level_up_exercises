require_relative 'custom_filter'
require_relative 'dinosaur'
require_relative 'filter'
require_relative 'operation'
require_relative 'operation_choice'
require 'json'
require 'pp'

class DinosaurOperations
  TWO_TONS_IN_LBS = 4000
  CUSTOM_QUERY_DESCRIPTION = 'Custom query (e.g. "diet: Carnivore, weight_in_lbs: 2200").'
  private_constant :TWO_TONS_IN_LBS, :CUSTOM_QUERY_DESCRIPTION

  def self.operations
    OperationChoice.new(*basic_filters, *nested_operations, *io_operations)
  end

  def self.basic_filters
    [
      Filter.new('Filter by bipeds.', proc { |d| d.walking == Dinosaur::WALKING_BIPED }),
      Filter.new('Filter by carnivores.', proc { |d| Dinosaur::CARNIVORE_DIETS.include?(d.diet) })
    ]
  end

  def self.nested_operations
    [
      Operation.new('Filter by period.', OperationChoice.new(*period_filters)),
      Operation.new('Filter by size.', OperationChoice.new(*size_filters)),
      Operation.new('Custom filter.', CustomFilter.new(CUSTOM_QUERY_DESCRIPTION))
    ]
  end

  def self.period_filters
    %w[Albian Cretaceous Jurassic Oxfordian Permian Triassic].map do |p|
      Filter.new("#{p} period.", proc { |d| d.period.include?(p) })
    end
  end

  def self.size_filters
    [
      Filter.new('Big (> 2 tons) dinosaurs.',
                 proc { |d| !d.weight_in_lbs.nil? && d.weight_in_lbs > TWO_TONS_IN_LBS }),
      Filter.new('Small dinosaurs.',
                 proc { |d| !d.weight_in_lbs.nil? && d.weight_in_lbs <= TWO_TONS_IN_LBS })
    ]
  end

  def self.io_operations
    [
      Operation.new('Print list.', print_dinosaurs),
      Operation.new('Print list in JSON.', print_dinosaurs_in_json),
      Operation.new('Exit.', proc { |_| exit })
    ]
  end

  def self.print_dinosaurs
    proc do |dinosaurs|
      dinosaurs.each { |d| PP.pp(d) }
    end
  end

  def self.print_dinosaurs_in_json
    proc do |dinosaurs|
      dinosaurs.each { |d| puts d.to_h.to_json }
    end
  end

  private_class_method :basic_filters, :nested_operations, :io_operations, :print_dinosaurs,
                       :print_dinosaurs_in_json, :period_filters, :size_filters
end
