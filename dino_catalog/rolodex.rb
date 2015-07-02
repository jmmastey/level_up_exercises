class Rolodex
  def initialize(headers)
    extend Hirb::Console

    @headers = headers
    create_header_methods
  end

  def query(data_set, command)
    puts "command: #{command}"
    return unless command.downcase.include?('=')
    key, value = command.split('=')
    query_command = { key => value }
    puts "query command: #{query_command}"

    method("query_#{key}").call(data_set, value)
  end

  def show_details(data_set, *values)
    data_set.select { |_key, value| values.include?(value) }
  end

  private

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
