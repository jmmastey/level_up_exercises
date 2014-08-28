module Utility
  module ObjectMixins
    def try(*a, &b)
      if a.empty? && block_given?
        yield self
      else
        public_send(*a, &b) if respond_to?(a.first)
      end
    end
  end
  Object.include(ObjectMixins)
  module SymbolMixins
    def include?(target)
      to_s.include?(target.to_s)
    end
  end
  Symbol.include(SymbolMixins)
end
