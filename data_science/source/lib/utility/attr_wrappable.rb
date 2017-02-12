module Utility
  module Wrappable
    def self.included(base)
      base.extend(Core)
    end
    module Hook
      def self.prepended(base)
        wrappables = base.instance_variable_get('@wrappables')
        wrappables.each { |(m, b)| define_method(m, &b) }
        define_method(:wrappables) { wrappables }
      end
    end
    module Core
      def attr_wrappable(method, &block)
        class_exec(method, block) do |m, b|
          @wrappables ||= {}
          @wrappables.merge!(m => b)
        end
        prepend Hook
      end
    end
  end
end
