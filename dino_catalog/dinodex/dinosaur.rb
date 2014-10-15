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
      lines = [format_field(:taxon, @taxon)]
      lines << format_timeperiod_field
      lines.concat(formatted_field_list)
      lines.concat(formatted_attribute_list)
      lines.compact.join("\n  ")
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

    def format_timeperiod_field
      return nil unless @time_period
      qualifier = @attributes[:time_period_qualifier]
      fieldvalue = (qualifier ? "#{qualifier} " : '') + @time_period.to_s
      format_field(:time_period, fieldvalue)
    end

    def format_field(fieldname, fieldvalue)
      return nil if fieldvalue.nil?
      "#{fieldname.to_s.gsub('_', ' ').capitalize}: #{fieldvalue}"
    end

    def formatted_field_list
      [:weight, :diet, :carnivorous, 
       :ambulation, :continent, :description].map do |fieldsym| 
        format_field(fieldsym, send(fieldsym))
      end
    end

    @@hide_attributes = [:time_period_qualifier]

    def formatted_attribute_list
      @attributes.sort.map do |attr_name, attr_val|
        unless @@hide_attributes.include?(attr_name) 
        then format_field(attr_name.to_s, attr_val)
        else nil
        end
      end
    end
  end
end
