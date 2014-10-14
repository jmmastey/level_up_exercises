class Dinosaur
	attr_reader :name
	attr_reader :period
	attr_reader :continent
	attr_reader :carnivore
	attr_reader :diet
	attr_reader :weight
	attr_reader :walking
	attr_reader :descriptor

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

	def all_variables()
    variables = self.instance_variables
    attributes = {}
    variables.each do |var|
    	unless self.instance_variable_get(var).nil?
    		attributes[var.to_s.tr('@','').capitalize] = (self.instance_variable_get(var))
    	end
    end
    attributes
  end
end # class Dinosaur
