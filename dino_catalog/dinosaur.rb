class Dinosaur
  attr_accessor :name,
    :period,
    :diet,
    :weight,
    :walking,
    :continent,
    :description,
    :weight_classification

  def initialize(properties)
    properties.each do |field, value|
      method("#{field}=").call(value)
    end
  end

  def to_s
    output = []

    to_hash.map { |field, value| output << "#{field}: #{value}" if value }

    output.join("\n")
  end

  def to_hash
    {
      name: name,
      period: period,
      diet: diet,
      weight: weight,
      walking: walking,
      continent: continent,
      description: description,
    }
  end

  def big?
    if @weight.to_i > (2204 * 2)
      'yes'
    else
      'no'
    end
  end

  def to_json(*args)
    to_hash.to_json(*args)
  end
end
