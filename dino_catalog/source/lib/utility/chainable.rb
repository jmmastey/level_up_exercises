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
        add_chainable_methods(results, prepend_hook)
      end

      private

      def add_chainable_methods(object, target)
        CHAINABLE_NAMES.each do |meth|
          object.define_singleton_method(meth, &target)
        end
        object
      end
    end
    module QueryMethods
      def attr_chainable(collection = :entries)
        class_eval("attr_accessor :#{collection}")
        class_eval %{
          def where(criteria, sample)
            sample ||= #{collection}
            sample.select { |entry| entry.matches_all?(criteria) }
          end
        }
      end
    end
  end
end
