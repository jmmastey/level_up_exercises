class Rolodex
  def initialize(headers, entity)
    extend Hirb::Console
    @options = []
    @headers = headers
    @entity = entity
    create_header_methods
  end

  def query(data_set, conditions)
    query_data_set = data_set.dup
    parse_conditions(conditions).each do |condition|
      query_data_set = check_conditions(condition, query_data_set)
    end
    query_data_set
  end

  def check_conditions(condition, data)
    data = process_condition_array(condition, data) if condition.class == Array
    data = process_condition_hash(condition, data) if condition.class == Hash
    data
  end

  def process_condition_array(condition, data)
    condition.each do |term|
      data = @entity.send(term, data) if term.class == Symbol
      data = search_data_text(data, term) unless term.class == Symbol
    end
    data
  end

  def process_condition_hash(condition, data)
    condition.reduce(data) do |entity_list, (key, value)|
      method("query_#{key}").call(entity_list, value)
    end
  end

  def show_details(data_set, *values)
    data_set.select { |_key, value| values.include?(value) }
  end

  private

  def parse_conditions(conditions)
    conditions.split(',').each_with_index do |condition, index|
      add_text_query(condition, index) if text_condition?(condition)
      add_qualifier_query(condition, index) if qualifier_condition?(condition)
      add_column_query(condition, index) if column_condition?(condition)
    end
    @options
  end

  def add_text_query(condition, index)
    search_term = []
    terms = condition.to_s.delete('"').delete("'")
    search_term << terms.strip
    add_to_conditions(search_term, index)
  end

  def add_qualifier_query(condition, index)
    qualifiers = [condition.strip.to_sym]
    add_to_conditions(qualifiers, index)
  end

  def add_column_query(condition, index)
    query_conditions = {}
    key, value = condition.split('=')
    query_conditions[key.delete(' ')] = value.delete(' ')
    add_to_conditions(query_conditions, index)
  end

  def text_condition?(condition)
    condition.to_s.match(/[^'"].*['"]/)
  end

  def qualifier_condition?(condition)
    condition.match(/big|small/)
  end

  def column_condition?(condition)
    condition.downcase.include?('=')
  end

  def add_to_conditions(condition, index)
    @options[index] = condition
  end

  def search_data_text(data_set, term)
    data_set.select do |_key, value|
      search_by_header_column(value, term)
    end
  end

  def search_by_header_column(value, term)
    term_found = false
    value.instance_variables.each do |header_variable|
      column_cell = value.instance_variable_get(header_variable)
      term_found = column_cell.to_s.include?(term) unless term_found
    end
    term_found
  end

  def create_header_methods
    @headers.each do |header|
      self.class.class_eval do
        define_method "query_#{header.downcase}" do |data_set, *query_term|
          query_by_header(header, data_set, query_term)
        end
      end
    end
  end

  def query_by_header(header, data_set, data)
    data_set.select do |_key, value|
      cell_data = value.method("#{header.downcase}").call
      data.any? { |item| cell_data.to_s.include?(item) }
    end
  end
end
