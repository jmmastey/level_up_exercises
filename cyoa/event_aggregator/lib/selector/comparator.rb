require "set"

module Selector
  class Comparator
    include Selector

    config_variable :field, :sql_operator, :criterion

    def generate_sql_fragment
      ["\"#{field}\" #{sql_operator} ?", criterion]
    end
  end
end
