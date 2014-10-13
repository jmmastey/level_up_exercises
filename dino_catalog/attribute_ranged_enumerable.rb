require "./attribute_conditioned_enumerable"

# An Enumerable collection of objects that's qualified by a filter condition
module FilteringEnumerable
  class AttributeRangedEnumerable < AttributeConditionedEnumerable
 
    attr_reader :lo_value
    attr_reader :hi_value

    def initialize(parent, attribute, low_value, hi_value, exclude_end = false)
      super(parent, attribute)
      @lo_value = lo_value
      @hi_value = hi_value
      exclusive(exclude_end)  # Call this initialize Range as member var
    end

    def exclusive?
      @exclusive
    end

    def exclusive(true_or_false)
      @exclusive = true_or_false
      @range = Range.new(lo_value, hi_value, exclusive?)  # Remake range
      self  # Support chaining
    end

    protected

    def keep_item?(item)
      @range.cover?(item_attr_val(item))
    end
  end
end

# Add interface to FilteringEnumerable mixin to expose this functionality
module FilteringEnumerable
  def between(attribute, lo_value, hi_value, exclusive = false)
    AttributeRangedEnumerable(self, attribute, lo_value, hi_value, exclusive)
  end
end
