require "./filtered_object_set"

# An Enumerable, queriable collection of objects that acting as factory for a
# filtered view of its items through a proxy interface to the underlying items'
# attributes.
module FilteringObjectSet
  include Enumerable

  # An unknown method is taken for a query condition against attributes of items
  def method_missing(attribute, *match_expressions)
    FilteredObjectSet.new(self, attribute, match_expressions)
  end

  def respond_to_missing?(attribute, include_all)
    true
  end
end
