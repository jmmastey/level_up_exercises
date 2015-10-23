class Dinosaur
  attr_reader :name, :period, :epoch, :continent, :diet,
              :weight_in_lbs, :walking, :description

  CARNIVORE_DIETS = %w(Carnivore Insectivore Piscivore)
  WALKING_BIPED = 'Biped'

  def initialize(attributes = {})
    @name = attributes[:name]
    @continent = attributes[:continent]
    @diet = attributes[:diet]
    @weight_in_lbs = attributes[:weight_in_lbs]
    @walking = attributes[:walking]
    @description = attributes[:description]

    assign_period_and_epoch(attributes[:period])
  end

  def pretty_print(pp)
    fields_to_print = to_h

    fields_to_print.map do |field_name, value|
      pp.text("#{field_name}: #{value}")
      pp.breakable
    end
  end

  def to_h
    fields_and_values = instance_variables
      .map { |field| [field, instance_variable_get(field)] }
      .select { |_, value| !value.nil? }
      .flat_map { |field, value| [printable_name(field), join_if_array(value)] }

    Hash[*fields_and_values]
  end

  private

  def assign_period_and_epoch(period)
    if period.nil?
      @period = nil
      @epoch = nil
    else
      @epoch = period.split(' or ') if period =~ /Early|Middle|Late/
      @period = period.split(' or ').map { |p| p.sub(/(?:Early|Middle|Late) /, '') }
    end
  end

  def printable_name(field_name)
    field_name.to_s.slice!(1..-1).split('_').map(&:capitalize!).join(' ')
  end

  def join_if_array(value)
    value.is_a?(Array) ? value.join(', ') : value
  end
end
