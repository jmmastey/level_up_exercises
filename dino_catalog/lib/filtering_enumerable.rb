# Enumerables which can filter based on filter method predicates
module FilteringEnumerable
  include Enumerable

  REGISTERED_FILTER_TYPE_FACTORIES = {}

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

  # For adding filter using syntax: enum.filter_type(:attribute, val1, ...)
  def method_missing(filter_method, *args, &_block)
    filtered_attr, *match_exprs = *args
    add_filter(filter_method, filtered_attr, *match_exprs)
  end

  def respond_to_missing?(method, include_all = false)
    super || REGISTERED_FILTER_TYPE_FACTORIES.include?(method)
  end

  def add_filter(filter_method, attribute,  *match_expressions)
    raise NoMethodError, "No such filter: #{filter_method}" unless
      (factory_method = REGISTERED_FILTER_TYPE_FACTORIES[filter_method])
    factory_method.call(self, attribute, *match_expressions)
  end

  def self.filter_methods
    REGISTERED_FILTER_TYPE_FACTORIES.keys
  end

  # For filter type implementations to register their name -> factory method
  def self.add_filter_type(filter_method_name, &factory_method)
    REGISTERED_FILTER_TYPE_FACTORIES[filter_method_name] = factory_method
  end
end

require "filtering_enumerable/enumerable_wrapper"
require "filtering_enumerable/attribute_filter"
require "filtering_enumerable/attribute_range_filter"
require "filtering_enumerable/attribute_match_filter"
require "filtering_enumerable/attribute_regexp_filter"
