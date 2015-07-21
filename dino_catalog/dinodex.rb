require_relative 'dinodex_runner'

def main
  runner = DinodexRunner.new
  runner.command_missing? ? runner.help : runner.execute_command
end

main
