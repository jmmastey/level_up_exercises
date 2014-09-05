# File cohort.rb
class Cohort
  attr_accessor :name, :visits, :conversions

  def initialize(name, options = {})
    self.name = name
    self.conversions ||= 0.0
    self.visits ||= 0.0
    options.each do |option, value|
      method("#{option}=").call(value)
    end
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

  def conversion_percent
    (conversion_rate * 100.0).round(3)
  end
end
