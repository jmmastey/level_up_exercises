# An Enumerable, queriable collection of objects that acts as factory for a
# filtered view of its items through a proxy interface to the underlying items'
# attributes. Actual filter implementations will contribute methods to this
# mixin that will add their functionality to this interface.
#
# Called as: (...or see #apply_filters)
#
# enum->filter(:attribute, val1, val2, ...)
#
module FilteringEnumerable
  include Enumerable

  # Registry of available filters {:method => filter factory}
  @@filter_factory_methods = {}

  # Return a new filtered enum applying all given filters to this one, as in:
  # enum.apply_filters {
  #   :foo => [:match, "bar", "baz"],
  #   :quux => [:regex_match, /xyzzy/i, /qux/],
  #   :dollars => [:between, 0, 10]
  # }
  def apply_filters(attr_filter_map)    # {:attr => [:filter, param1, ...]}
    attr_filter_map.each_pair.reduce(self) do |enum, (attr, (method, *params))|
      enum.add_filter(method, attr, *params)
    end
  end

  def method_missing(filter_method, *args, &_block)
    filtered_attr, *match_exprs = *args
    add_filter(filter_method, filtered_attr, *match_exprs)
  end

  def respond_to_missing?(method, include_all = false)
    super || @@filter_factory_methods.include?(method)
  end

  def add_filter(filter_method, attribute,  *match_expressions)
    raise NoMethodError, "No such filter: #{filter_method}" unless
      (factory_method = @@filter_factory_methods[filter_method])
    factory_method.call(self, attribute, *match_expressions)
  end

  def self.filter_methods
    @@filter_factory_methods.keys
  end

  # Filter implementation classes register a factory method and method name to
  # invoke it with the filter arguments. (See #add_filter)
  def self.add_filter_method(filter_method_name, &factory_method)
    @@filter_factory_methods[filter_method_name] = factory_method
  end
end

require "filtering_enumerable/enumerable_wrapper"
require "filtering_enumerable/attribute_conditioned_enumerable"
require "filtering_enumerable/attribute_ranged_enumerable"
require "filtering_enumerable/attribute_matching_enumerable"
require "filtering_enumerable/attribute_regexpmatch_enumerable"
