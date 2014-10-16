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
      fields_and_values.map do |fieldname, fieldvalue|
        "#{fieldname.to_s.gsub('_', ' ').capitalize}: #{fieldvalue}"
      end.join("\n")
    end

    def to_hash
      fields_and_values.reduce({}) { |h, (field, value)| h[field] = value.to_s; h }
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

    def output_field_list
      [:taxon, :time_period, :weight, :diet, 
       :carnivorous, :ambulation, :continent, :description]
    end

    def fields_and_values
      output_field_list.map do |fieldsym| 
        fieldvalue = send(fieldsym)
        fieldvalue.nil? ? nil : [fieldsym, fieldvalue]
      end.compact
    end
  end
end
