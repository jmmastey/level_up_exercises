class Dino
  ATTRIBUTES = %w(name period continent diet weight walking description)

  attr_accessor *ATTRIBUTES

  def initialize(data)
    data.each do |key, val|
      send("#{key}=", val)
    end
  end

  def properties
    ATTRIBUTES.each_with_object({}) do |attr, hash|
      hash[attr] = send(attr)
    end
  end

  def to_s
    properties.inject("") do |output_str, tuple|
      formatted_attribute = "#{tuple[0].capitalize}:".ljust(20)

      bad_value = tuple[1].nil? || tuple[1].strip == ''
      formatted_value = bad_value ? '---' : tuple[1]

      output_str << "#{formatted_attribute}#{formatted_value}\n"
    end
  end
end
