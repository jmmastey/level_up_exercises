class AndToken
  attr_reader :field, :op, :arg
  
  def self.accepts?(parts)
    parts[0] == "AND" && parts.size == 4
  end

  def initialize(parts)
    @field = parts[1]
    @op = parts[2]
    begin
      @arg = Integer(parts[3])
    rescue
      @arg = parts[3]
    end
  end

  def apply_to(dino_query)
    dino_query.and(@field, @op, @arg)
  end
end

class SortToken < AndToken
  attr_reader :field
 
  def self.accepts?(parts)
    parts[0] == "SORT" && parts.size == 2
  end

  def initialize(parts)
    @field = parts[1]
  end

  def apply_to(dino_query)
    dino_query.sort(@field)
  end
end
