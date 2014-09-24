# rubocop:disable all
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
  Object.include(ObjectMixins) unless Object.included_modules.include?(ObjectMixins)
  module HashMixins
    def inverse
      inject({}) do |hash, (key, array)|
        array.map { |word| hash[word] = key }
        hash
      end
    end

    def try(*a, &b)
      if a.size == 1
        k = a.first
        return self[k] if key?(k) && !respond_to?(k)
      end
      super(*a, &b)
    end

    def <<(hash)
      merge!(hash)
    end
  end
  Hash.include(HashMixins) unless Hash.included_modules.include?(HashMixins)
  module StringMixins
    def snake_case
      return downcase if match(/\A[A-Z]+\z/)
      strip.gsub(' ', '_').
      gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2').
      gsub(/([a-z])([A-Z])/, '\1_\2').
      downcase
    end
  end
  String.include(StringMixins) unless String.included_modules.include?(StringMixins)
  module SymbolMixins
    def include?(target)
      to_s.include?(target.to_s)
    end

    def snake_case
      to_s.snake_case.to_sym
    end
  end
  Symbol.include(SymbolMixins) unless Symbol.included_modules.include?(SymbolMixins)
  module TextMixins
    def text?
      true
    end
  end
  [String, Symbol].each { |i| i.include(TextMixins) unless i.included_modules.include?(TextMixins) }
end
# rubocop:enable all
