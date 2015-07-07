class Dinosaur
  attr_accessor :genus, :weight, :walking, :continent, :description,
    :carnivore, :diet_details, :periods
  def initialize(dinosaur)
    @genus = dinosaur[:genus]
    @weight = dinosaur[:weight]
    @walking = dinosaur[:walking]
    @continent = dinosaur[:continent]
    @description = dinosaur[:description]
    @diet_details = dinosaur[:diet_details]
    @carnivore = dinosaur[:carnivore]
    @periods = dinosaur[:periods]
  end

  def to_s
    result = "Dino Details:"

    print_order = [:genus, :periods, :description, :weight, :walking,
                   :continent, :carnivore, :diet_details]

    print_order.each do |field|
      if field
        result << "\n#{field.to_s.titleize}: "
        if (field != :periods)
          result << self.send(field).to_s
        else
          result << generate_period_string
        end
      end
    end

    result
  end

  private

  def generate_period_string
    period_string = formatted_periods.join(" or ")
  end

  def formatted_periods
    periods.map{ |period| formatted_period(period) }
  end

  def formatted_period period
    [period[:modifier], period[:period]].compact.join(" ")
  end
end
