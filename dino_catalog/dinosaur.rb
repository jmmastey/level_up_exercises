require 'pp'

class Dinosaur

  def initialize(dino_data=[])
    @dinosaur_data = dino_data
    @dino_name = @dinosaur_data['name']
    @biped = @dinosaur_data['walking']
    @quadriped = @dinosaur_data['walking']
    @weigh = @dinosaur_data['weight'].to_i
    @diet_type = @dinosaur_data['diet']
    @continent = @dinosaur_data['continent']
    @life_period = @dinosaur_data['period']
  end

  def biped?
    @biped == "Biped"
  end

  def quadriped?
    @quadriped == "Quadriped"
  end

  def continent_from?(continent_name)
    @continent.include?(continent_name)
  end

  def period?(time_period)
    @life_period.include?(time_period)
  end

  def information?(dinosaur_name)
    @dino_name.has_value?(dinosaur_name)
  end

  def weight?(weight_in_tonnes)
    @weigh > weight_in_tonnes.to_i
  end

  def diet?(diet)
  @diet_type.include?(diet)
  end

  def to_s
    print "Name of dinosaur #{@dino_name}, walking style - #{@biped}, from #{@life_period} period was a #{@diet_type}"
    print " living in #{@continent}" if !@continent.nil?
    print " weighing #{@weigh}" if @weigh>0
  end

  def match_criteria(criteria)
    criteria.all? { |method_name, _param_value| filter_criteria(method_name, criteria) }
  end

  def filter_criteria(method_name, criteria)
    begin
      case method_name
      when "Walking" then send("#{criteria[method_name].downcase}?")
      when "Continent" then send(:continent_from?, criteria[method_name])
      else
        send("#{method_name.downcase}?", criteria[method_name])
      end
    rescue
      raise "No method error! Please enter a valid criteria like this: Walking-Biped, Diet-Carnivore.. etc"
    end
  end
end
