require "set"

module SelectionCriterion
  class Comparator
    include SelectionCriterion

    config_variable :field, :sql_operator, :criterion

    def generate_sql
      "\"#{field}\" #{sql_operator} ?"
    end
  end
end
