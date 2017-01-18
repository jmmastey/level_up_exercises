require 'pp'

class Dinosaur

  attr_reader :name, :walking, :weight, :diet, :continent, :period
  def initialize(dino_data)
    @dino_name = dino_data['name']
    @walking = dino_data['walking']
    @weigh = dino_data['weight'].to_i
    @diet_type = dino_data['diet']
    @continent = dino_data['continent']
    @life_period = dino_data['period']
  end

  def biped?
    @walking == "Biped"
  end

  def quadriped?
    @walking == "Quadriped"
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
    print "Name of dinosaur #{@dino_name}, walking style - #{@walking}, from #{@life_period} period was a #{@diet_type}"
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
