
class AndToken
  attr_reader :field, :op, :arg

  def initialize(parts)
      @field = parts[1]
      @op = parts[2]
      @arg = parts[3]
  end

  def execute_token(dino_query)
    dino_query.and(@field,@op,@arg)
  end
end

class SortToken < AndToken
  attr_reader :field
  def initialize(parts)
    @field = parts[1]
  end
  def execute_token(dino_query)
    dino_query.sort(@field)
  end
end
