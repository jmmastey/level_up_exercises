# An Enumerable, queriable collection of objects that acts as factory for a
# filtered view of its items through a proxy interface to the underlying items'
# attributes. Actual filter implementations will contribute methods to this
# mixin that will add their functionality to this interface.
#
# Called as:
#
# enum->attribute(:filter, val1, val2, ...)
#
# When a subclass registers a method to the module 
# filter(attribute, val1, val2, ...) that returns an instance of such a filter
#
# eg: enum->favorite_color(:matches, :blue)
#
module FilteringEnumerable
  include Enumerable

  # Callbacks are called with this Enumerable as parent and any given arguments
  @@filter_factory_methods = {}

  def method_missing(filter_method, *args, &block)
    filtered_attr, *match_exprs = *args
    add_filter(filter_method, filtered_attr, *match_exprs)
  end

  def respond_to_missing?(method, include_all = false)
    super || @@filter_factory_methods.include?(method)
  end

  def add_filter(filter_method, attribute,  *match_expressions)
    factory_method = @@filter_factory_methods[filter_method] or
      raise NoMethodError.new("No such filter: #{filter_method}")
    factory_method.call(self, attribute, *match_expressions)
  end

  class << self
    def filter_methods
      @@filter_factory_methods.keys
    end

    def add_filter_method(filter_method_name, &factory_method)
      @@filter_factory_methods[filter_method_name] = factory_method
    end
  end
end

require "filtering_enumerable/enumerable_wrapper"
require "filtering_enumerable/attribute_conditioned_enumerable"
require "filtering_enumerable/attribute_ranged_enumerable"
require "filtering_enumerable/attribute_matching_enumerable"
require "filtering_enumerable/attribute_regexpmatch_enumerable"

