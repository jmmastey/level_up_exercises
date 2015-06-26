class DataTransformer
  def initialize(map)
    @map = map
  end

  def transform(val)
    return apply_transform(val) if @map
    val
  end

  private

  def apply_transform(match)
    @map.each { |k, v| return k if Array(v).include?(match) }
    match
  end
end
