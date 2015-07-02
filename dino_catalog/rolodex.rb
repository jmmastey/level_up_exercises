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
      condition.each do |key, value|
        query_data_set = method("query_#{key}").call(data_set, value)
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
      return unless condition.downcase.include?('=')
      key, value = condition.split('=')
      query_conditions = { key => value }
      puts "query conditions: #{query_conditions}"
      add_to_conditions(query_conditions, index)
    end
    @options
  end

  def add_to_conditions(condition, index)
    @options[index] = condition
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
