class Dinosaur

  def initialize(dino_data=[])
    @dinosaur_data = dino_data
  end

  def walking(walking_type)
    @dinosaur_data['walking'] == walking_type
  end

  def period?(period)
    @dinosaur_data['period'].include?(period)
  end

  def continent?(continent_name)
    @dinosaur_data['continent'].include?(continent_name) if @dinosaur_data.has_key?('continent')
  end

  def diet?(diet)
    @dinosaur_data[diet.downcase] == 'Yes' || @dinosaur_data['diet'] == diet.capitalize
  end

  def weight?(weight_in_tonnes)
    @dinosaur_data['weight_in_lbs'].to_i > weight_in_tonnes.to_i || @dinosaur_data['weight'].to_i > weight_in_tonnes.to_i
  end

  def information?(dinosaur_name)
    @dinosaur_data.has_value?(dinosaur_name)
  end

  def match_criteria(criteria)
    criteria.all?{ |method_name, param_value| filter_criteria(method_name, criteria) }
  end

  #def criteria_not_matches?(method_name)
  # !Dinosaur.method_defined?(:"#{method_name.downcase}?") && !(method_name.downcase).eql?("walking")
  #end

  def filter_criteria(method_name, criteria)
    begin
      if ["Walking"].include?(method_name)
        send("#{method_name.downcase}", criteria[method_name]) if ["Walking"].include?(method_name)
      else
        send("#{method_name.downcase}"+"?", criteria[method_name])
      end
    rescue Exception => e
      raise "No method error! Please provide valid input like this: Walking-Biped, Diet-Carnivore, etc.."
    end
  end

end
