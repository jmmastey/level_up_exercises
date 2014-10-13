require "./attribute_ranged_enumerable"
require "./attribute_matching_enumerable"

# An Enumerable, queriable collection of objects that acts as factory for a
# filtered view of its items through a proxy interface to the underlying items'
# attributes. Actual filter implementations will contribute methods to this
# mixin that will add their functionality to this interface.
module FilteringEnumerable
  include Enumerable

  # An unknown method is taken for a query condition against attributes of items
  def method_missing(attribute, *match_expressions)
    query(attribute, *match_expressions)
  end

  def respond_to_missing?(attribute, include_all)
    true
  end
end
