class Dino

  def initialize(attributes: nil, details: nil)
    # puts attributes,details

    create(attributes, details) if attributes && details
  end

  def create(attributes, details)
    attributes.each_with_index do |attribute, i|
      self.instance_variable_set("@#{attribute.downcase}",details[i])
      self.instance_eval { class << self; self end }.send(:attr_accessor, "#{attribute.downcase}")
    end
  end

end
