class Dino
  def initialize(attributes: nil, details: nil)
    # puts attributes,details
    create(attributes, details) if attributes && details
  end

  private

  def create(attributes, details)
    attributes.each_with_index do |attribute, i|
      set_attributes(attribute, details[i])
    end
  end

  def set_attributes(attribute, values)
    instance_variable_set("@#{attribute.downcase}", values)
    instance_eval { class << self; self end }
      .send(:attr_accessor, "#{attribute.downcase}")
  end
end
