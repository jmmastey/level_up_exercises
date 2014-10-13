# Can be negated
# imlements the each and offers virtual keep_item? methods
module FilteringEnumerable
  class AttributeConditionedEnumerable
    include FilteringEnumerable

    def initialize(parent, filter_attribue)
      @parent = parent
      @filter_attribute = filter_attribute
    end

    # Implements Enumerable
    def each
      @parent.each do |item| 
        yield item if item.respond_to?(@filter_attribute) && keep_item?(item)
      end
    end

    protected 

    # Overridden in subclass to implement an actual selection condition
    def keep_item?(item)
      raise NotImplementedError
    end
  end
end
