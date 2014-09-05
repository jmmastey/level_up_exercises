require "./string"

class DinoQuery
  def initialize(data=[])
    @data=data
  end

  def and(key,op,arg)
    @data.keep_if {|dino| dino.send(key).send(op,arg) }
    self
  end

  def sort(field)
    @data.sort_by! {|dino| dino.send(field) }
    self
  end

  def result
      @data
  end
end

