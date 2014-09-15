require "./dinocommand"

class DinoQuery
  attr_reader :result

  def initialize(dinos = [])
    @result = dinos
  end

  def and!(key, op, arg)
    @result.keep_if { |dino| dino.send(key).send(op, arg) }
    self
  end

  def sort!(field)
    @result.sort_by! { |dino| dino.send(field) }
    self
  end

  def perform_commands!(commands)
    commands.each { |command| perform_command!(command) }
    self
  end

  def perform_command!(command)
    return and!(command.field, command.op, command.arg) if command.is_a? AndCommand
    return sort!(command.field) if command.is_a? SortCommand
    fail "Command not found for query!: #{command}"
  end
end
