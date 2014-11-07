module DinosaurIndex
  class Dinosaur
    include Data

    attr_accessor :taxon, :weight, :continent, :description, :other_attributes,
                  :part_of_period

    attr_reader :diet, :posture, :time_period

    def initialize(taxon, other = {})
      @taxon = taxon
      initialize_from_options(other)
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

    def specific_period
      (part_of_period ? "#{part_of_period} " : '') + time_period.to_s.capitalize
    end

    def to_hash
      Hash[fields_and_values.map { |(field, value)| [field, value.to_s] }]
    end

    private

    def initialization_options
      %w(time_period  part_of_period weight diet  posture continent description)
    end

    def initialize_from_options(construction_options)
      options = construction_options.dup
      initialization_options.each do |attribute|
        instance_variable_set("@#{attribute}".to_sym, options.delete(attribute))
        @other_attributes = dinosaur_attributes
      end
    end

    def output_field_list
      [:taxon, :specific_period, :weight, :diet,
       :carnivorous?, :posture, :continent, :description]
    end

    def fields_and_values
      output_field_list.map do |fieldsym|
        fieldvalue = send(fieldsym)
        fieldvalue.nil? ? nil : [fieldsym, fieldvalue]
      end.compact
    end
  end
end
