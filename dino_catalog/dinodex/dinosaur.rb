module Dinodex
  class Dinosaur
    # Fields
    attr_accessor :taxon        # Name of dinosaur
    attr_accessor :time_period  # When dinosaur lived
    attr_accessor :weight       # Weight of animals in lbs
    attr_accessor :diet         # What dinosaur ate
    attr_accessor :ambulation   # Mode of locomotion
    attr_accessor :continent    # Geographic region of residence
    attr_accessor :description  # Human-readable informational message

    # Other potential attributes
    attr_accessor :attributes   # Other information

    def initialize(taxon, other = {})
      @taxon = taxon
      decode_options(other)
    end

    def carnivorous
      diet ? diet.carnivorous : nil
    end

    def to_s
      taxon
    end

    def full_description
      formatted_field_list.compact.join("\n")
    end

    private

    def decode_options(options)
      @time_period = options.delete(:time_period)
      @weight = options.delete(:weight)
      @diet = options.delete(:diet)
      @ambulation = options.delete(:ambulation)
      @continent = options.delete(:continent)
      @description = options.delete(:description)
      @attributes = options   # Whatever's left
    end

    def format_field(fieldname, fieldvalue)
      fieldvalue && "#{fieldname.to_s.gsub('_', ' ').capitalize}: #{fieldvalue}"
    end

    def formatted_field_list
      [:taxon, :time_period, :weight, :diet, :carnivorous, 
       :ambulation, :continent, :description].map do |fieldsym| 
        format_field(fieldsym, send(fieldsym))
      end
    end
  end
end
