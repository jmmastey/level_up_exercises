require './string'

class DinoQuery
  attr_reader :result

  def initialize(data = [])
    @result = data
  end

  def and(key, op, arg)
    @result.keep_if { |dino| dino.send(key).send(op, arg) }
    self
  end

  def sort(field)
    @result.sort_by! { |dino| dino.send(field) }
    self
  end
end
