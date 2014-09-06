module Utility
  module Chainable
    def self.included(container)
      container.prepend(QueryHook)
      container.extend(QueryMethods)
    end
    module QueryHook
      CHAINABLE_NAMES = [:where, :with, :and]

      def where(criteria, sample = nil)
        this = self
        results = super(criteria, sample)
        prepend_hook = proc { |hash| this.where(hash, results) }
        add_chainable_methods(results, &prepend_hook)
      end

      private

      def add_chainable_methods(object, &target)
        object.instance_exec(CHAINABLE_NAMES, target) do |a, target|
          a.each { |i| define_singleton_method(i, &target) }
          self
        end
      end
    end
    module QueryMethods
      def attr_chainable(receiver, product, *aliases, &block)
        class_eval("attr_accessor :#{receiver}")
        class_eval %{
          def where(criteria, sample)
            sample ||= #{receiver}
            sample.select { |entry| entry.matches_all?(criteria) }
          end
        }
      end
    end
  end
end