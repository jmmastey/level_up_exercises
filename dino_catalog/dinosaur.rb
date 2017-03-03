require_relative 'dino_csv_cleaner'
require_relative 'hash'

class Dinosaur
  def initialize
  end

  def small?
    weight && weight <= 2000
  end

  def big?
    weight && weight > 2000
  end

  def biped?
    walking == 'Biped'
  end

  def create_attribute(*headers)
    self.class.class_exec do
      headers.map do |h|
        h.map { |header| attr_accessor header }
      end
    end
  end
end
