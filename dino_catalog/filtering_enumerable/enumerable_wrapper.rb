# Wrap an enumerable object with the filtering behavior and otherwise
# impersonate the wrapped object by proxy
module FilteringEnumerable
  class EnumerableWrapper
    include FilteringEnumerable

    def initialize(wrapped_enumerable)
      @wrapped_enumerable = wrapped_enumerable
    end

    def method_missing(method, *args, &block)
      # Give preference to the wrapped enumerable so I impersonate it well
      if @wrapped_enumerable.respond_to?(method)
        @wrapped_enumerable.send(method, *args, &block)
      else
        super
      end
    end

    def respond_to_missing?(method, include_all = false)
      super || @wrapped_enumerable.respond_to?(method, include_all)
    end
  end
end
