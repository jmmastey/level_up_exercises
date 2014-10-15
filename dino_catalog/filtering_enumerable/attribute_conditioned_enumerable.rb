require "filtering_enumerable/enumerable_wrapper"

# Can be negated
# imlements the each and offers virtual keep_item? methods
module FilteringEnumerable
  class AttributeConditionedEnumerable < EnumerableWrapper
    include FilteringEnumerable

    attr_reader :filter_attribute

    def initialize(parent, filter_attribute)
      super(parent)
      @filter_attribute = filter_attribute
      @negated = false
      @exclude_nil = false
    end

    def negated?
      @negated
    end

    def negate
      @negated = !@negated
      self
    end

    # Whether to automatically fail items with nil attribute values in filter
    def exclude_nil(true_or_false = true)
      @exclude_nil = true_or_false
      self
    end

    def exclude_nil?
      @exclude_nil
    end

    # Implements Enumerable
    def each
      @wrapped_enumerable.each do |item| 
        yield item if item_passes_filter?(item)
      end
    end

    protected 

    # Encapsulate @filter_attribute
    def item_attr_val(item)
      item.respond_to?(@filter_attribute) ? item.send(@filter_attribute) : nil
    end

    def item_passes_filter?(item)
      (exclude_nil? && item_attr_val(item).nil?) ? false
                                                 : negated? ^ keep_item?(item)
    end

    # Overridden in subclass to implement an actual selection condition
    def keep_item?(item)
      raise NotImplementedError
    end
  end
end
