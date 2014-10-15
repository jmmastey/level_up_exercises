# Wrap an enumerable object with the filtering behavior and otherwise
# impersonate the wrapped object by proxy
module FilteringEnumerable
  class EnumerableWrapper
    include FilteringEnumerable

    def initialize(wrapped_enumerable)
      @wrapped_enumerable = wrapped_enumerable
    end

    def method_missing(method, *args, &block)
      if i_can_do_it?(method)
        super
      else
        @wrapped_enumerable.send(method, *args, &block)
      end
    end

    # superclass' version knows my inherent capabilities vs. delegated
    alias_method :i_can_do_it?, :respond_to_missing?
    
    def respond_to_missing?(method, include_all = false)
      i_can_do_it?(method, include_all) || 
        @wrapped_enumerable.respond_to_missing?(method, include_all)
    end
  end
end
