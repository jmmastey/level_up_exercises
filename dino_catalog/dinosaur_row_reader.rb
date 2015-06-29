class DinosaurRowReader
  attr_accessor :values

  def parse_row(_row)
    raise NotImplementedError, "this base class should never be initiated"
  end
end
