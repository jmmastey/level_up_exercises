require "filtering_enumerable"

# Wrap an enumerable object with the "queriable" behavior and otherwise
# impersonate the wrapped object by proxy
class QueriableArray < FilteringEnumerable::EnumerableWrapper
  def initialize
    super([])
  end
end


