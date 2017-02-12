require_relative 'operation'

class Filter < Operation
  def initialize(message, filter)
    super(message, proc { |dinosaurs| dinosaurs.select!(&filter) })
  end
end
