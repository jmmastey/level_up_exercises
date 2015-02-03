class Dinosaur
  def name
    @name
  end

  def name=(name)
    @name = name
  end

  def period
    @period
  end

  def period=(period)
    @period = period
  end

  def continent
    @continent
  end

  def continent=(continent)
    @continent = continent
  end

  def diet
    @diet
  end

  def diet=(diet)
    @diet = diet
  end

  def weight
    @weight
  end

  def weight=(weight)
    @weight = weight
  end

  def walking
    @walking
  end

  def walking=(walking)
    @walking = walking
  end

  def description
    @description
  end

  def description=(description)
    @description = description
  end

  def to_json
    {'name' => @name, 'period' => @period, 'continent' => @continent, 'diet' => @diet,
      'weight' => @weight, 'walking' => @walking, 'description' => @description}
  end
end