class Dinosaur
  attr_accessor :genus, :weight, :walking, :continent, :description,
    :carnivore, :diet_details, :periods

  PRINT_ORDER = [:genus, :periods, :description, :weight, :walking,
                 :continent, :carnivore, :diet_details]

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

    PRINT_ORDER.each do |field|
      next if send(field).to_s.empty?

      result << "\n#{titleize(field.to_s)}: "
      if (field != :periods && field != :carnivore)
        result << send(field).to_s
      elsif field == :periods
        result << generate_period_string
      else
        result << (@carnivore ? "Yes" : "No")
      end
    end

    result
  end

  def biped?
    @walking.downcase == "biped"
  end

  def carnivore?
    @carnivore.downcase == "yes"
  end

  def big?
    @weight.to_i > 4000
  end

  private

  def generate_period_string
    formatted_periods.join(" or ")
  end

  def formatted_periods
    periods.map { |period| formatted_period(period) }
  end

  def formatted_period(period)
    [period[:modifier], period[:period]].compact.join(" ")
  end

  def titleize(word)
    word.split("_").map(&:capitalize).join(" ")
  end
end
