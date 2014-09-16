module Utility
  module Accessible
    def self.included(base)
      base.extend(self)
    end
    def attr_accessible?(v)
      respond_to?(v.to_sym) && respond_to?("#{v}=".to_sym)
    end
  end
end
