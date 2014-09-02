class DinoQuery
  
  def initialize(data=[])
    @data=data
  end

  def and(key,op,arg)
    query = DinoQuery.new
    @data.keep_if {|dino| dino.send(key).send(op,arg) }
    return self
  end

  def sort(field)
    @data.sort_by! {|dino| dino.send(field) }
    return self
  end

  def result
    return @data
  end
end

