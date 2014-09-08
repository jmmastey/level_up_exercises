module Utility
  module Wrappable
    def self.included(base)
      base.instance_eval %{
        @wrappables ||= {}
        attr_accessor :wrappables
      }
      base.extend(Core)
    end
    module Hook
      def self.prepended(base)
        wrappables = base.instance_variable_get("@wrappables")
        wrappables.each{ |(m, b)| define_method(m, &b) }
      end
    end
    module Core
      def attr_wrappable(method, &block)
        instance_exec(method, block) { |m, b| @wrappables.merge!(m => b) }
        build_wrappable_module(method, &block)
      end

      private

      def build_wrappable_module(method_name, &block)
        # hook = Hook.clone
        prepend Hook
      end
    end
  end
end