class Dinodex::Dinosaur

  attr_accessor :taxon        # Name of dinosaur
  attr_accessor :time_period  # When dinosaur lived
  attr_accessor :weight       # Weight of animals in lbs
  attr_accessor :diet         # What dinosaur ate
  attr_accessor :ambulation   # Mode of locomotion
  attr_accessor :continent    # Geographic region of residence
  attr_accessor :description  # Human-readable informational message

  def initialize(taxon, time_period, weight, ambulation, other = {})

    @taxon, @time_period, @weight, @ambulation = 
      taxon, time_period, weight, ambulation
    @diet = other[:diet]
    @description = other[:description]
    @continent = other[:continent]
  end

  def carnivorous?
    diet.carnivorous?
  end

  def to_s 
    taxon
  end

  def full_description
    printed_field_list.compact.join("\n")
  end

  private

  def printed_field_list
    [:taxon, :time_period, :weight,
        :diet, :ambulation, :continent, :description].map do |fieldsym|
      (fieldval = send(fieldsym)) ?
        "#{fieldsym.to_s.gsub('_', ' ').capitalize}: #{fieldval}" : nil
    end
  end
end
