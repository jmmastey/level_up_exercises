class Dinosaur
  CARNIVORE_DIET ||= %w(insectivore piscivore carnivore)
  VALID_PARAMS ||= %i(name period continent diet
                      carnivore weight walking description)

  def initialize(params = {})
    filtered_params = filter_params(params)
    filtered_params.each do |name, value|
      self.class.send(:attr_accessor, name.to_sym)
      instance_variable_set("@#{name}", value)
    end
  end

  def filter_params(params)
    params.keep_if { |key, value| VALID_PARAMS.include?(key) && !value.nil? }
    if params.key?(:diet)
      params[:carnivore] = 'Yes' if CARNIVORE_DIET.include?(params[:diet].downcase)
    end
    params
  end

  def formatted_variables
    attributes = {}
    instance_variables.each do |var|
      attributes[format_var_name(var)] = format_var_value(var)
    end
    attributes
  end

  def format_var_value(value)
    instance_variable_get(value) + "\n------"
  end

  def format_var_name(name)
    "------\n" + name.to_s.tr('@', '').capitalize
  end
end
