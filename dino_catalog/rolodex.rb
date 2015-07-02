class Rolodex
  def initialize
    extend Hirb::Console
  end

  def query(data_set, command)
    puts "command: #{command}"
    return unless command.downcase.include?('=')
    key, value = command.split('=')
    puts "key: #{key}, value: #{value}"
    query_command = { key => value }
    puts "query command: #{query_command}"
  end

  def show_details(data_set, *values)
    data_set.select { |_key, value| values.include?(value) }
  end
end
