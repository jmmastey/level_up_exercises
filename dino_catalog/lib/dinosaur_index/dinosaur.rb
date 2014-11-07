module DinosaurIndex
  class Dinosaur
    attr_accessor :taxon, :time_period, :weight, :diet, :posture,
                  :continent, :description, :other_attributes

    def initialize(taxon, other = {})
      @taxon = taxon
      intialize_from_options(other)
    end

    def to_s
      taxon
    end

    def full_description
      fields_and_values.map do |fieldname, fieldvalue|
        "#{fieldname.to_s.gsub('_', ' ').capitalize}: #{fieldvalue}"
      end.join("\n")
    end

    def diet=(a_diet)
      raise InvalidDataError, 
            "No such diet #{a_diet}" unless legal_diet?(a_diet)
      @diet = a_diet
    end

    def time_period=(a_period)
      raise InvalidDataError,
            "No such period #{a_period}" unless legal_time_period?(a_period)
      @time_period = a_period
    end

    def posture=(a_posture)
      raise InvalidDataError,
            "No such posture: #{a_posture}" unless legal_posture?(a_posture)
      @posture = a_posture
    end

    def to_hash
      Hash[fields_and_values.map { |(field, value)| [field, value.to_s] }]
    end

    private

    def initialize_from_options(options)
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
