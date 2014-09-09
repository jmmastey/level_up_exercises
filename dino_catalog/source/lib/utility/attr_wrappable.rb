module Utility
  module Wrappable
    def self.included(base)
      base.extend(Core)
    end
    module Hook
      def self.prepended(base)
        wrappables = base.instance_variable_get('@wrappables')
        wrappables.each { |(m, b)| define_method(m, &b) }
      end
    end
    module Core
      def self.extended(base)
        base.instance_eval %(
          @wrappables ||= {}
          attr_accessor :wrappables
        )
      end
      def attr_wrappable(method, &block)
        instance_exec(method, block) { |m, b| @wrappables.merge!(m => b) }
        prepend Hook
      end
    end
  end
end
