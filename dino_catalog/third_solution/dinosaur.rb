class Dinosaur

  attr_reader :name, :weight, :diet, :locomotion, :period, :additional_info
  def initialize(args)
    @name             =   args[:name]
    @weight           =   args[:weight]
    @diet             =   args[:diet]
    @locomotion       =   args[:locomotion]
    @period           =   args[:period]
    @additional_info  =   args[:additional_info]
  end

  def big?
    weight && weight >= 4000
  end

  def carnivore?
    diet && ["piscivore", "carnivore", "insectivore"].include?(diet.downcase)
  end

  def biped?
    locomotion && locomotion.downcase == "biped"
  end

  def from?(age)
    period && period.downcase.include?(age.downcase)
  end

  def attribute_value?(attribute, value)
    self.send(attribute) != nil && self.send(attribute).downcase == value.downcase
  end

  def additional_info_value?(additional_info_catagory, additional_info_value)
    category = additional_info_catagory.downcase
    search_term = additional_info_value.downcase
    self.additional_info != nil &&
    self.additional_info.has_key?(category) && 
    self.additional_info[category] !=nil && 
    self.additional_info[category].downcase.include?(search_term)
  end

  def to_s
    self.instance_variables.each_with_object([]) do |attribute, output|
      next if !self.instance_variable_get(attribute)
      if attribute == :@additional_info 
        additional_info.each do |k, v|
          if v
            output << "#{k}: #{v}"
          end
        end
      else
        output << "#{attribute.to_s[1..-1]}: #{self.instance_variable_get(attribute)}"
      end
    end.compact.join(", ") + "\n\n"
  end

  def to_h
    self.instance_variables.each_with_object({}) do |attribute, output|
      next if !self.instance_variable_get(attribute)
      output[attribute.to_s[1..-1]] = self.instance_variable_get(attribute)
    end
  end
end