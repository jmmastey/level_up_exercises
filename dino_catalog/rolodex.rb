class Rolodex
  def initialize(headers)
    extend Hirb::Console
    @options = []
    @headers = headers
    create_header_methods
  end

  def query(data_set, conditions)
    query_data_set = data_set.dup
    search_conditions = parse_conditions(conditions)
    puts "Search Conditions: #{search_conditions}"

    search_conditions.each do |condition|
      puts "Condition: #{condition}" # ["jurassic"]
      # Column conditions will be hashes.
      # Text conditions will be arrays of strings.

      if condition.class == Array
        condition.each do |term|
          query_data_set = search_data_text(query_data_set, term)
        end
      end

      if condition.class == Hash
        condition.each do |key, value|
          query_data_set = method("query_#{key}").call(data_set, value)
        end
      end
    end

    query_data_set
  end

  def show_details(data_set, *values)
    data_set.select { |_key, value| values.include?(value) }
  end

  private

  def parse_conditions(conditions)
    conditions.split(',').each_with_index do |condition, index|
      text = text_condition(condition, index)
      column_condition(condition, index) unless text
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

  def column_condition(condition, index)
    return false unless condition.downcase.include?('=')
    key, value = condition.split('=')
    query_conditions = { key => value }
    puts "query conditions: #{query_conditions}"
    add_to_conditions(query_conditions, index)
    true
  end

  def add_to_conditions(condition, index)
    @options[index] = condition
  end

  def search_data_text(data_set, term)
    # key = value from data set
    # value = Dinosaur objects
    data_set.select do |key, value|
      result = (key == term)
      value.instance_variables.each do |header_variable|
        values = value.instance_variable_get(header_variable)
        result = values.to_s.include?(term) unless result
      end
      result
    end
  end

  def create_header_methods
    @headers.each do |header|
      self.class.class_eval do
        define_method "query_#{header.downcase}" do |data_set, data|
          # data = jurassic (command)
          # data_set = {"Abrictosaurs"=>#<Dinosaur:000>}
          data_set.select do |_key, value|
            # key = Abrictosaurus || value = <Dinosaur:000>
            values = value.method("#{header.downcase}").call
            values.to_s.include?(data)
          end
        end
      end
    end
  end
end
