# Can be negated
# imlements the each and offers virtual keep_item? methods
module FilteringEnumerable
  class AttributeConditionedEnumerable
    include FilteringEnumerable

    attr_reader :filter_attribute

    def initialize(parent, filter_attribute)
      @parent = parent
      @filter_attribute = filter_attribute
      @negated = false
    end

    def negated?
      @negated
    end

    def negate
      @negated = !@negated
      self
    end

    # Implements Enumerable
    def each
      @parent.each do |item| 
        yield item if 
          negated? ^ (item.respond_to?(@filter_attribute) && keep_item?(item))
      end
    end

    protected 

    # Encapsulate @filter_attribute
    def item_attr_val(item)
      item.send(@filter_attribute)
    end

    # Overridden in subclass to implement an actual selection condition
    def keep_item?(item)
      raise NotImplementedError
    end
  end
end
