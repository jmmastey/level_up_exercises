class Dinosaur
  attr_reader :name,:period,:continent,:carnivore,:diet,:weight,:walking,:descriptor

  def initialize( params = {})
    @name = params[:name]
    @period = params[:period]
    @continent = params[:continent]
    @carnivore = params[:carnivore]
    @diet = params[:diet]
    @weight = params[:weight]
    @walking = params[:walking]
    @descriptor = params[:descriptor]
    unless diet.nil?
      @carnivore = 'Yes' if ['insectivore', 'piscivore', 'carnivore'].include?(@diet.downcase)
    end # unless diet.nil?
  end # def initialize

  def all_variables
    variables = instance_variables
    attributes = {}
    variables.each do |var|
      unless instance_variable_get(var).nil?
        attributes[var.to_s.tr('@','').capitalize] = (instance_variable_get(var))
      end
    end
    attributes
  end
end # class Dinosaur
