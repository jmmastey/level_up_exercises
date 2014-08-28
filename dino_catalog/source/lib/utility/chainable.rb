module Utility
  module Chainable
    def where(criteria, sample = nil)
      this = self
      results = super(criteria, sample)
      hook_where = proc { |criteria| this.where(criteria, results) }
      [:where, :with, :and].each do |meth|
        results.define_singleton_method(meth, &hook_where)
      end
      results
    end
  end
end
