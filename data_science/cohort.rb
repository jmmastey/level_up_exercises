# File cohort.rb
class Cohort
  attr_accessor :name, :visits, :conversions

  def initialize(name)
    self.name = name
    self.conversions ||= 0.0
    self.visits ||= 0.0
  end

  def add_visits
     self.visits += 1.0
  end

  def add_conversions
    self.conversions += 1.0
  end

  def conversion_rate
    self.conversions.to_f / self.visits.to_f
  end

end