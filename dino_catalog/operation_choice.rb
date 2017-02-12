require_relative 'operation'

class OperationChoice
  def initialize(*operations)
    @operations = operations
  end

  def call(items)
    print_choices
    index = valid_operation_index
    @operations[index].call(items)
  end

  private

  def print_choices
    @operations.each_with_index { |f, i| puts "#{i + 1}. #{f.message}" }
  end

  def valid_operation_index
    Kernel.loop do
      index = operation_index
      break index if valid_index?(index)
      puts 'Invalid option.'
    end
  end

  def operation_index
    print '> '
    choice = $stdin.readline.chomp.to_i
    puts
    choice - 1
  end

  def valid_index?(index)
    index >= 0 && index < @operations.size
  end
end
