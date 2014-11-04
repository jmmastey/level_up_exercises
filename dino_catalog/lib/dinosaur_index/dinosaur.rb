module DinosaurIndex
  class Dinosaur
    attr_accessor :taxon, :time_period, :weight, :diet, :posture,
                  :continent, :description, :other_attributes

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
      Hash[fields_and_values.map { |(field, value)| [field, value.to_s] }]
    end

    private

    def decode_options(options)
      @time_period = options.delete(:time_period)
      @weight = options.delete(:weight)
      @diet = options.delete(:diet)
      @posture = options.delete(:posture)
      @continent = options.delete(:continent)
      @description = options.delete(:description)
      @other_attributes = options
    end

    def output_field_list
      [:taxon, :time_period, :weight, :diet,
       :carnivorous, :posture, :continent, :description]
    end

    def fields_and_values
      output_field_list.map do |fieldsym|
        fieldvalue = send(fieldsym)
        fieldvalue.nil? ? nil : [fieldsym, fieldvalue]
      end.compact
    end
  end
end
