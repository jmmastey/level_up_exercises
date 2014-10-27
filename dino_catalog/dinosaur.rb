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
    params.delete_if { |key| !VALID_PARAMS.include?(key) }
    params[:carnivore] = 'Yes' if CARNIVORE_DIET.include?(params[:diet])
    params
  end

  def formatted_variables_hash
    attributes = {}
    instance_variables.each do |var|
      attributes[format_var(var)] = format_key(var)
    end
    attributes
  end

  def format_key(key)
    key.to_s + "\n------"
  end

  def format_var(var)
    "------\n" + var.to_s.tr('@', '').capitalize
  end
end

puts Dinosaur.new(name: 'Claw', diet: nil, monster: 'yes').formatted_variables_hash
