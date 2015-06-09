module Commands
  COMMANDS = %w(help list export exit manual)

  FLAGS = {
    list: %w(-c -d -f -h -n -p -s -w),
    export: %w(-n),
  }

  def self.err_cmd(cmd)
    "> Unrecognized command: #{cmd}\n\n"
  end

  def self.err_flag(param)
    "> Invalid flag: #{param.first}\n\n"
  end

  def self.err_params(params)
    "> Unrecognized parameters: #{params}\n\n"
  end

  def self.valid_cmd?(cmd)
    COMMANDS.include?(cmd.downcase)
  end
end
