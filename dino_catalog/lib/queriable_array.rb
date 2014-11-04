require "filtering_enumerable"

class QueriableArray < FilteringEnumerable::EnumerableWrapper
  def initialize
    wrapThisEnumerable = []
    super(wrapThisEnumerable)
  end
end
