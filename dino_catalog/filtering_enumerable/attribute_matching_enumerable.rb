require "filtering_enumerable/attribute_conditioned_enumerable"

# An Enumerable collection of objects that's qualified by a filter condition
module FilteringEnumerable
  class AttributeMatchingEnumerable < AttributeConditionedEnumerable
    
    attr_reader :match_expressions

    def initialize(parent, filter_attribute, *match_expressions)
      super(parent, filter_attribute)
      @match_expressions = match_expressions
    end

    private

    def keep_item?(item)
      @match_expressions.include?(item_attr_val(item))
    end
  end
end

# Add interface to FilteringEnumerable mixin to expose this functionality
module FilteringEnumerable
  add_filter_method(:match) do |parent, attribute, *match_expressions|
    AttributeMatchingEnumerable.new(parent, attribute, *match_expressions)
  end
end
