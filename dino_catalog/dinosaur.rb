class Dinosaur
  BIPED         = "Biped"
  QUADRUPED     = "Quadruped"
  CRETACEOUS    = "Cretaceous"
  BIG_THRESHOLD = 2000
  CARNIVORE     = %w(carnivore insectivore piscivore)

  attr_reader :name, :continent, :diet, :weight_in_lbs, :walking, :description

  def initialize(params = {})
    @name          = params[:name]
    @period        = params[:period]
    @continent     = params[:continent]
    @diet          = params[:diet]
    @weight_in_lbs = params[:weight_in_lbs]
    @walking       = params[:walking]
    @description   = params[:description]
  end

  def biped?
    @walking == BIPED
  end

  def period
    if @period.include? CRETACEOUS
      CRETACEOUS
    else
      @period
    end
  end

  def carnivore?
    !@diet.nil? && CARNIVORE.include?(@diet.downcase)
  end

  def big_dinosaur?
    @weight_in_lbs >= BIG_THRESHOLD
  end

  def display
    display_by_key('name')
    display_by_key('period')
    display_by_key('continent')
    display_by_key('diet')
    display_by_key('weight_in_lbs')
    display_by_key('walking')
    display_by_key('description')
  end

  private

  def titelize(key)
    key.split("_").map(&:upcase).join(" ")
  end

  def display_by_key(key)
    return unless value = instance_variable_get("@#{key}")

    title = titelize key
    display_field title, value
  end

  def display_field(title, value)
    puts format("%-15s: %s", title, value)
  end
end
