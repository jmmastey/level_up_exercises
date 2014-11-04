require "filtering_enumerable/enumerable_wrapper"

module FilteringEnumerable
  class AttributeFilter < EnumerableWrapper
    include FilteringEnumerable

    attr_reader :filter_attribute, :negated, :excludes_nil

    def initialize(parent, filter_attribute)
      super(parent)
      @filter_attribute = filter_attribute
      @negated = false
      @exclude_nil = false
    end

    def negate
      @negated = !@negated
      self
    end

    # Whether to automatically fail items with nil attribute values in filter
    def exclude_nil(true_or_false = true)
      @excludes_nil = true_or_false
      self
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
      !(excludes_nil && item_attr_val(item).nil?) && (negated ^ keep_item?(item))
    end

    # Overridden in subclass to implement an actual selection condition
    def keep_item?(_item)
      raise NotImplementedError
    end
  end
end
