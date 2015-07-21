class DinoFilter
  attr_accessor :dino_attr, :desired_value

  def initialize(dino_attr, desired_value)
    @dino_attr = dino_attr.to_s.downcase
    @desired_value = desired_value.to_s.downcase
  end

  def search(dinosaurs)
    if permissive_search?
      specialized_search(dinosaurs, ->(a, b) { a.include? b })
    else
      specialized_search(dinosaurs, ->(a, b) { a == b })
    end
  end

  def permissive_search?
    "period" == dino_attr
  end

  def specialized_search(dinosaurs, block)
    dinosaurs.select do |dino|
      attr_value = dino.method(dino_attr).call
      downcase_attr_value = attr_value.to_s.downcase
      block.call(downcase_attr_value, desired_value)
    end
  end
end
