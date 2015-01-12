module Selector
  class Comparator
    include Selector

    config_variable :field, :sql_operator, :criterion

    def sql_fragment
      ["\"#{field}\" #{sql_operator} '%s'", criterion]
    end

    def self.selector_description
      "Field comparison"
    end

    def selector_description
      self.class.selector_description
    end
  end
end
