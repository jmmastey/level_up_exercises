class Dinosaur
  attr_accessor :name, :period, :continent, :diet, :weight, :walking, :description

  @@labels = {
    :name => "Name",
    :period => "Period",
    :continent => "Continent",
    :diet => "Diet",
    :weight => "Weight (in lbs)",
    :walking => "Walking",
    :description => "Description"
  }

  def to_h
    {:name => self.name,
     :period => self.period,
     :continent => self.continent,
     :diet => self.diet,
     :weight => self.weight,
     :walking => self.walking, 
     :description => self.description}.
     select { |key , value| value != nil }
  end

  def to_json (*args)
    self.to_h.to_json *args
  end

  def to_s
    str = ""
    self.to_h.each do |key, value|
      str << @@labels[key] << ": " << value.to_s << "\n"
    end

    str
  end
end
