class Dinosaur
  BIPED                  = "Biped"
  QUADRUPED              = "Quadruped"
  CRETACEOUS             = "Cretaceous"
  BIG_DINOSAUR_THRESHOLD = 2000
  CARNIVORE              = %w(carnivore insectivore piscivore)
  ATTRIBUTES             = %w(name
                              period
                              continent
                              diet
                              weight_in_lbs
                              walking
                              description
                           )

  attr_reader :name, :continent, :diet, :weight_in_lbs, :walking, :description

  def initialize(params = {})
    ATTRIBUTES.each do |attr|
      var_name = "@#{attr}"
      instance_variable_set(var_name, params[attr.to_sym])
    end
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
    !!@diet && CARNIVORE.include?(@diet.downcase)
  end

  def big_dinosaur?
    @weight_in_lbs >= BIG_DINOSAUR_THRESHOLD
  end

  def display
    ATTRIBUTES.each { |attr| display_by_key attr }
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
