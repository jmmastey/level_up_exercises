class Dinosaur
  attr_accessor :name, :continent, :period, :weight, :walking, :description, :diet

  DATA_CONVERSIONS = {
    Yes:  "Carnivore",
    No:   "Herbivore",
  }

  def initialize(args)
    args.each do |key, value|
      value = normalize_data(value)
      instance_variable_set("@#{key}", value)
    end
  end

  def normalize_data(data = "")
    return data if data.nil? || DATA_CONVERSIONS[(data.to_sym)].nil?
    DATA_CONVERSIONS[data.to_sym]
  end

  def larger_than?(size)
    return false if weight.nil?
    Float(weight) > Float(size)
  end

  def smaller_than?(size)
    return false if weight.nil?
    !larger_than?(size)
  end

  def export_facts(facts = "")
    to_hash.each do |header, value|
      next if value.empty?
      header = header.gsub(/[A-Za-z']+/, &:capitalize)
      facts << sprintf("%-15s %s\n", header, value)
    end
    facts
  end

  def to_hash
    instance_variables.each_with_object({}) do |var, data|
      fact_header  = "#{clean_attr_name(var)}"
      fact_value   = "#{instance_variable_get(var)}"
      data[fact_header] = fact_value
    end
  end

  private

  def clean_attr_name(attribute_name)
    attribute_name.to_s.gsub(/:|@/, "")
  end
end
