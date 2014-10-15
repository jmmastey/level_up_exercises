# FilteringEnumerable wrapper that filters by regular expression match
module FilteringEnumerable
  class AttributeRegexpmatchEnumerable < AttributeConditionedEnumerable

    def initialize(parent, filter_attribute, *match_patterns)
      super(parent, filter_attribute)
      @match_patterns = match_patterns
    end

    protected
    
    def keep_item?(item)
      @match_patterns.any? { |regexp| regexp.match(item_attr_val(item)) }
    end
  end

  # Register filter method to FilteringEnumerable to make available
  add_filter_method(:match_regex) do |parent, attribute, *match_patterns|
    AttributeRegexpmatchEnumerable.new(parent, attribute, *match_patterns)
  end
end
