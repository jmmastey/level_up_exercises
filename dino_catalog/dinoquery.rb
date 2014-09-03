class DinoQuery
  
  def initialize(data=[])
    @data=data
  end

  def and(key,op,arg)
    if key == nil
      raise "Key is nil"
    end
    if op == nil
      raise "op is nil"
    end
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

