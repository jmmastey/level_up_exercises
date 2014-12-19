require "set"

module Selector
  class Comparator
    include Selector

    config_variable :field, :sql_operator, :criterion

    def generate_sql
      "\"#{field}\" #{sql_operator} ?"
    end
  end
end
