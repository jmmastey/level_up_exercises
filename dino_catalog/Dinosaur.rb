class Dinosaur
  attr_accessor :name, :location, :period, :weight, :walk_type, :description
  attr_reader :diet

  def diet=(str)
    str = ("Carnivore" if str == "Yes") || (nil if str == "No")
    @diet = str
  end

  def larger_than?(size)
    return false if weight.nil?
    Float(weight) > Float(size)
  end

  def smaller_than?(size)
    return false if weight.nil?
    !larger_than?(size)
  end

  def print_facts
    instance_variables.each do |instance_var|
      next unless instance_variable_get(("#{instance_var}"))
      fact_header  = "[#{clean_attr_name(instance_var).gsub(/[A-Za-z']+/, &:capitalize)}]"
      fact_value   = "#{instance_variable_get(("#{instance_var}"))}"
      printf("%-15s %s\n", fact_header, fact_value)
    end
  end

  def export_hash
    hash = {}
    instance_variables.each do |instance_var|
      fact_header  = "#{clean_attr_name(instance_var)}"
      fact_value   = "#{instance_variable_get(("#{instance_var}"))}"
      hash[fact_header] = fact_value
    end
    hash
  end

  private

  def clean_attr_name(attribute_name)
    attribute_name.to_s.gsub(/:|@/, "")
  end
end
