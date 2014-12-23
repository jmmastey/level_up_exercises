require "set"

module Selector
  class Comparator
    include Selector

    config_variable :field, :sql_operator, :criterion

    def sql_fragment
      ["\"#{field}\" #{sql_operator} '%s'", criterion]
    end
  end
end
