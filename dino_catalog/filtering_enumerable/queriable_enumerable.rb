# Wrap an enumerable object with the "queriable" behavior and otherwise
# impersonate the wrapped object by proxy
class QueriableEnumerable
  include FilteringEnumerable

  def initialize(an_enumerable = [])
    @wrapped_enumerable = an_enumerable
  end

  def method_missing(method, *args, &block)
    if @wrapped_enumerable.respond_to?(method)
      @wrapped_enumerable.send(method, *args, &block)
    else
      super
    end
  end
end


