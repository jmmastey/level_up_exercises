class Rolodex
  attr_reader :entity

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
    if condition.class == Array
      condition.each do |term|
        data = entity.send term, data if term.class == Symbol
        data = search_data_text(data, term) unless term.class == Symbol
      end
    end

    if condition.class == Hash
      condition.each do |key, value|
        data = method("query_#{key}").call(data, value)
      end
    end

    data
  end

  def show_details(data_set, *values)
    data_set.select { |_key, value| values.include?(value) }
  end

  private

  def parse_conditions(conditions)
    conditions.split(',').each_with_index do |condition, index|
      valid_text = text_condition(condition, index)
      valid_qualifier = qualifier_condition(condition, index) unless valid_text
      column_condition(condition, index) unless valid_text || valid_qualifier
    end
    @options
  end

  def text_condition(condition, index)
    match = condition.to_s.match(/[^'"].*['"]/)
    return false unless match
    search_term = []
    terms = condition.to_s.delete('"').delete("'")
    search_term << terms.strip
    add_to_conditions(search_term, index)
    true
  end

  def qualifier_condition(condition, index)
    return unless condition.match(/big|small/)
    qualifiers = []
    qualifiers << condition.to_sym
    add_to_conditions(qualifiers, index)
    true
  end

  def column_condition(condition, index)
    return false unless condition.downcase.include?('=')
    query_conditions = {}
    key, value = condition.split('=')
    query_conditions[key.delete(' ')] = value.delete(' ')
    add_to_conditions(query_conditions, index)
    true
  end

  def add_to_conditions(condition, index)
    @options[index] = condition
  end

  def search_data_text(data_set, term)
    data_set.select do |key, value|
      result = (key == term)
      search_by_header_column(value, term, result)
    end
  end

  def search_by_header_column(value, term, result)
    value.instance_variables.each do |header_variable|
      values = value.instance_variable_get(header_variable)
      result = values.to_s.include?(term) unless result
    end
    result
  end

  def create_header_methods
    @headers.each do |header|
      self.class.class_eval do
        define_method "query_#{header.downcase}" do |data_set, *data|
          query_by_header(header, data_set, data)
        end
      end
    end
  end

  def query_by_header(header, data_set, data)
    data_set.select do |_key, value|
      valid_data = false
      values = value.method("#{header.downcase}").call
      data.each { |item| valid_data = values.to_s.include?(item) }
      valid_data
    end
  end
end
