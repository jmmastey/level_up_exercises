class Dinosaur
  def initialize(args = {})
    create_instance_variables(args)
    create_getters
  end

  def to_s
    valid_fields = all_info.reject { |_k, v| v.nil? }
    valid_fields.each_with_object("") do |(k, v), output|
      output << "#{k.capitalize}: #{v}\n"
    end
  end

  private

  def create_instance_variables(args)
    args.each { |k, v| instance_variable_set("@#{k}", v) }
  end

  def create_getters
    instance_variables.each do |var|
      self.class.send(:define_method, "#{var[1..-1]}") do
        instance_variable_get(var)
      end
    end
  end

  def all_info
    instance_variables.each_with_object({}) do |var, info|
      info[var[1..-1].to_sym] = instance_variable_get(var)
    end
  end
end
