class Dinosaur
  attr_accessor :name, :period, :continent, :diet, :weight, :walking, :description

  def to_json
    {'name' => @name, 'period' => @period, 'continent' => @continent, 'diet' => @diet,
      'weight' => @weight, 'walking' => @walking, 'description' => @description}
  end
end